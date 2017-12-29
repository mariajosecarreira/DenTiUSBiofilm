**DentiusBiofilm** is a toolbox for computation of bacterial vitality for in situ oral biofilm

The objective is to compare the bacterial viability with and without brushing and with different kinds of colutories (Essential oils vs Clorhexidin)
The volunteers carry on an **IDODS** (intraoral device of overlaid disk-holding splints) split model with several disks and fields to measure the vitality of bacterias on accumulated biofilm
Images are acquired through a confocal microscopy

For each patient with IDODS (intraoral device of overlaid disk-holding splints): 
 * number of disks (different places of IDODS around the dental arcade)
 * number of fields 1 micrometer thickness
 * number of layers in z-axis from confocal microscopy

**DentiusBiofilm** automatically computes the bacterial vitality for each patient for each experiment although each patient have different number of disks/fields/layers. It works with the informantion of folder hierarchy.

**DentiusBiofilm** automatically eliminates from the computation the non vital pixels belonging to *epithelial cell nuclei*

**DentiusBiofilm** stores all the vitality results (with and without considering epithelial cell nuclei) in a spreadsheet called  `EE_results.xlsx`. It also stores number and properties of endothelial cell nuclei. 


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