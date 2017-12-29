%This script computes the bacterial vitality for in situ oral biofilm
%The objective is to compare the bacterial viability with and without
%brushing and with different kinds of colutories (Essential oils vs Clorhexidin)
%The volunteers carry on an IDODS (intraoral device of overlaid disk-holding splints)
%split model with several disks and fields to measure the vitality of bacterias on
%accumulated biofilm
%Images are acquired through a confocal microscopy

%For each patient with IDODS: 
%number of disks (different places of IDODS)
%number of fields 1 micrometer thickness
%number of frames in z-axis from confocal microscopy

%Cleaning of variables, figures and command window
clear all; close all; clc
%Disable all warnings, almost all referring to image size
warning('OFF','all');

%CONSTANTS THAT CAN BE MODIFIED, PROPERTIES OF EPITHELIAL CELL NUCLEI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold_HIGH=100;
threshold_LOW=50;
MinArea=200;
MinSolidity=0.7;
MinMeanIntensity=180;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CONSTANTS THAT CAN BE MODIFIED, MAXIMUM NUMBER OF DISKS, FIELDS AND LAYERS
%PER PATIENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ndisks=6;
    nfields=4;
    nlayers=50;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%EXAMPLE OF EXPERIMENT SET:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMAGE FOLDER: SET1
%EXPERIMENT FOLDER: E1
%PATIENT FOLDER: VC (initials or code for anonimous patient)
%     FORMAT OF FILES INSIDE SET1/E1/VC:
%     VC_E1_D1C1_z000_red.tif AND VC_E1_D1C1_z000_green.tif
%     Dd=disk number d, Cc=field number c, zxxx=layer number xxx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image folder: one folder per experiment, one folder per patient
folder_img=input('Image folder (. if same folder as this script): ','s');
folder_exp=input('Experiment folder (Example: E1): ','s');
%for each file, Enexp is the name of the experiment folder
exp=folder_exp; 

%In the following, the user introduces the folders for all patients to
%analyze in the experiment exp

%First patient folder (usually patient initials)
folder_patient=input('Patient folder (Example: VQ): ','s');
%Initialization of patients data
patients={};num_patients=0;
%Storing of all patient folders in cell array patients{}
while ~isempty(folder_patient)
    num_patients=num_patients+1;
    patients{num_patients}=folder_patient; 
    %Subsequent patients folder
    folder_patient=input('Patient folder (Example: VQ) (enter for finish): ','s');
end

%The previous sentences are to prepare the program to analyze all the
%patients and take the time it needs to do that. The program now computes
%all the parameters and finish storing the results in a worksheet inside
%the experiment folder. So if there are a lot of patients with a lot of
%images, you can go out and come later.
for p=1:num_patients
    %File begins with patient initials
    patient=patients{p}; 
    %Initialization of results for patient p
    MR=[];%results matrix
    MN=[];%matrix which stores data of epithelial cell nuclei
    
    %Analysis of files for patient p
    fprintf('\tProcessing patient %s...\n',patient);
    for d=1:ndisks
        for c=1:nfields
            for z=1:nlayers
                %Automatically computes the name of each file
                %General prefix
                file_input=sprintf('%s/%s/%s_%s_D%dC%d_z%03d_',folder_exp,patient,patient,exp,d,c,z);
                %Green channel file (alife bacterias)
                file_input_green=sprintf('%s/%sgreen.tif',folder_img,file_input);
                %Red channel file (dead bacterias)
                file_input_red=sprintf('%s/%sred.tif',folder_img,file_input);
                
                file=fopen(file_input_green);
                %If this file exists (not all patients have the maximum
                %number of disks with the maximum number of fields with the
                %maximum number of layers)
                if (file>0)
                    fclose(file);
                    %Reading of green channel
                    fG=imread(file_input_green);
                    %Reading of red channel
                    fR=imread(file_input_red);
                    
                    %Eliminate % prefix in next 2 lines to show RGB image
                    %fB=fR.*0; fcolour=cat(3,fR,fG,fB);
                    %figure('Name',file_input), imshow(fcolour,'InitialMagnification','fit')
                    
                    %Masks with values greater than threshold_HIGH (100)
                    maskG=im2bw(fG,threshold_HIGH/255);%green>threshold_HIGH
                    maskR=im2bw(fR,threshold_HIGH/255);%red>threshold_HIGH
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %FIRST STAGE: COMPUTATION OF VITALITY PIXELS (GREEN)
                    %VITAL(alife): green (green>threshold_HIGH and red<threshold_HIGH)
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    mask_V=and(maskG,not(maskR));
                    %Eliminate % in following 2 lines if you want to show vital green pixels
                    %fcolourV=cat(3,uint8(mask_V).*fR,uint8(mask_V).*fG,uint8(mask_V).*fB);
                    %figure('Name','ALIFE: G>100 and R<100'), imshow(fcolourV,'InitialMagnification','fit')
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %Computation of vital pixels: green
                    area_alife=sum(mask_V(:)==1);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %SECOND STAGE: COMPUTATION OF DEAD PIXELS (RED and ORANGE)
                    %NON VITAL (dead): orange (green and red over threshold_HIGH)
                    %NON VITAL (dead): red (green<threshold_HIGH and red>threshold_HIGH)
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %ORANGE(green and red over threshold_HIGH)
                    mask_orange=and(maskG,maskR);
                    %Eliminate % in following 2 lines if you want to show non vital orange pixels
                    %fcolour_orange=cat(3,uint8(mask_orange).*fR,uint8(mask_orange).*fG,uint8(mask_orange).*fB);
                    %figure('Name','NO VITAL: ORANGE: G>100 and R>100'), imshow(fcolour_orange,'InitialMagnification','fit')
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %Computation of non vital pixels: orange
                    area_orange=sum(mask_orange(:)==1);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %RED(green<threshold_HIGH and red>threshold_HIGH)
                    mask_red=and(not(maskG),maskR);
                    %Eliminate % in following 2 lines if you want to show non vital red pixels
                    %fcolour_red=cat(3,uint8(mask_red).*fR,uint8(mask_red).*fG,uint8(mask_red).*fB);
                    %figure('Name','NOVITAL(BACTERIES+EPITHELIAL CELLS NUCLEI): RED (G<100 and R>100)'), imshow(fcolour_red,'InitialMagnification','fit')
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %Computation of non vital pixels: red
                    area_red=sum(mask_red(:)==1);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %RESULT: Percentage of vitality WITHOUT ELIMINATING EPITHELIAL CELL NUCLEI
                    vitality=area_alife/(area_alife+area_orange+area_red);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %CORRECTION OF SECOND STAGE: DETECTION AND ELIMINATION
                    %OF EPITHELIAL CELL NUCLEI FROM COMPUTATION OF RED PIXELS
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %Epithelial cell nuclei are characterized by solid and big red regions
                    %We will detect these regions analyzing red image with red>threshold_HIGH
                    
                    %First, isolated red points are eliminated in mask_red
                    mask_nuclei=bwmorph(mask_red,'clean',Inf);
                    
                    %Second, connected components with connectivity 4 are identified
                    cc=bwconncomp(mask_nuclei,4);
                    
                    %Third, we compute the following properties of connected components: 
                    %area, solidity, mean intensity and centroid
                    stats=regionprops(cc,fR,'Area','Solidity','MeanIntensity','centroid');
                                        
                    %Search for regions with properties as established in constants at the beginning of this script
                    idx=find([stats.Area]>=MinArea & [stats.Solidity]>=MinSolidity & [stats.MeanIntensity]>=MinMeanIntensity);
                    %Inizialitation of sum of areas of epithelial cell nuclei
                    area_nuclei=0;
                    if ~(isempty(idx))%if there is any nuclei
                        %Mask for regions identified as epithelial cell nuclei
                        mask_nuclei=ismember(labelmatrix(cc),idx);
                        %Eliminate % in following 2 lines if you want to show epithelial cell nuclei
                        %fcolour_nuclei=cat(3,uint8(mask_nuclei).*fR,uint8(mask_nuclei).*fG,uint8(mask_nuclei).*fB);
                        %figure('Name','NOVITAL RED EPITHELIAL CELL NUCLEI (Area>MinArea, solidity>MinSolidity, MeanIntensity>MinMeanIntesity)'), imshow(fcolour_nuclei,'InitialMagnification','fit')
                        
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %Computation of epithelial cell nuclei (red, big,solid regions)
                        area_nuclei=sum(mask_nuclei(:)==1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
                        %Properties of regions marked as nuclei are stored in MN matrix
                        for j=1:length(idx)
                            MN=[MN;d,c,z,j,stats(idx(j)).Area,stats(idx(j)).Solidity,stats(idx(j)).MeanIntensity,stats(idx(j)).Centroid];
                        end
                        
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %RESULT: Percentage of vitality ELIMINATING EPITHELIAL CELL NUCLEI
                        vitality_ECN=area_alife/(area_alife+area_orange+area_red-area_nuclei);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    else
                        vitality_ECN=vitality;
                    end
                    %Results are stored in results matrix MR
                    MR=[MR;d,c,z,area_alife,area_red,area_orange,area_nuclei,length(idx),vitality*100,vitality_ECN*100];
                    close all %delete all figures
                end %end of file
            end %end of layers
        end %end of fields
    end %end of disks
    
    %Storing of results if matrix of result is not empty
    if ~isempty(MR)
        %We store matrix and parameters in a worksheet file inside the image folder
        output=sprintf('%s/%s_results.xlsx',folder_img,exp);
        sheet=sprintf('%s_%s',folder_exp,patient);
        Cell={'disk','field','layer','area_alife','area_red','area_orange','area_nuclei','num_nuclei','%vital','%vital_no_ECN'};
        xlswrite(output,Cell,sheet);
        xlswrite(output,MR,sheet,'A2');
    end
    %Storing of properties of epithelial cell nuclei, if matrix is not empty
    if ~isempty(MN)
        sheet_ECN=sprintf('%s_%s_ECN',folder_exp,patient);
        Cell_ECN={'disk','field','layer','n','area','solidity','mean_intensity','centroid_x','centroid_y'};
        xlswrite(output,Cell_ECN,sheet_ECN);
        xlswrite(output,MN,sheet_ECN,'A2');
    end
end
fprintf('Finished... Results in file %s\n\n',output);