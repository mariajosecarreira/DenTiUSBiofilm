**Dentius_Biofilm** is a toolbox for computation of bacterial viability for *in situ* oral biofilm

*Author: Maria J. Carreira (CiTIUS, USC)*

*Collaborators: Inmaculada Tomás, Carlos Balsa-Castro, Victor Quintas, Isabel Prada-López (Oral Sciences Research Group, USC)*

*Reference paper with use of the toolbox: Quintas V, Prada-López I, Carreira MJ, Suárez-Quintanilla D, Balsa-Castro C and Tomás I: *In Situ* Antibacterial Activity of Essential Oils with and without Alcohol on Oral Biofilm: A Randomized Clinical Trial. Front. Microbiol. 8:2162. doi: 10.3
Frontiers in Microbiology, vol. November 2017, no. 23. 2017*

Different objectives have been performed applying this toolbox. Firstly, to compare the bacterial viability of the in situ oral biofilm with different types of antiseptics
(Clorhexidine, Essential oils with alcohol and alcohol-free Essential oils). Secondly, to compare the bacterial viability of an artificial substrate-formed in situ biofilm 
with a supragingivally tooth-formed biofilm in the same individuals, as well as the impact that the intraoral device/disk position and toothbrushing had during the biofilm’s 
formation.


The volunteers carry on an IDODS (iIntraoral dDevice of oOverlaid dDisk-holding sSplints) split model with several disks and fields to measure the viability of bacterias on 
accumulated biofilm *in situ*.

Images are acquired through a confocal microscopy, after staining the biofilm samples with the LIVE/DEAD® BacLight™ solution.

For each patient with IDODS (intraoral device of overlaid disk-holding splints): 
 * number of disks (different places of IDODS around the dental arcade)
 * number of fields 1 micrometer thickness
 * number of layers in z-axis from confocal microscopy

**Dentius_Biofilm** automatically computes the bacterial viability for each patient for each experiment although each patient have different number of disks/fields/layers. It works with the information of folder hierarchy.

**Dentius_Biofilm** automatically eliminates from the computation the non vital pixels belonging to *epithelial cell nuclei*

**Dentius_Biofilm** stores all the viability results (with and without considering epithelial cell nuclei) in a spreadsheet called  `EE_results.xlsx`. It also stores number and properties of endothelial cell nuclei. 


## Usage

The images are classified within a **set**, then within an **experiment** and then within a **patient**, each hierarchically in **their own folder**, so images for the patient `VC` for experiment `E1` and set `Set1` will be inside the folder `Set1/E1/VC`. The format of images is the following, being `PP`the patient initials, `EE` the experiment, `d` the disk number, `c` the field number and `XXX` the layer number:
```
 * Green image, named `PP_EE_Dd_Cc_zXXX_green.tif`
 * Red image, named `PP_EE_Dd_Cc_zXXX_red.tif`
```
There is an example included in the repository, with all the folder hierarchy in file `Set1.zip`:

```
Set1/E1/VC/VC_E1_DdCc_zXXX_green.tif
Set1/E1/VC/VC_E1_DdCc_zXXX_red.tif
Set1/E1/VQ/VQ_E1_DdCc_zXXX_green.tif
Set1/E1/VQ/VQ_E1_DdCc_zXXX_red.tif
```

With the included images you can run the following example:

 * Image folder: `Set1`
 * Experiment folder: `E1`
 * Patient folder: `VC`
 * Patient folder `VQ`