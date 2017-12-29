**DentiusBiofilm** is a toolbox for computation of oral biofilm vitality

Zebrafish (_Danio rerio_) is a model organism that has emerged as a tool for **cancer
research**, cancer being the second most common cause of death after cardiovascular
disease for humans in the developed world.

Zebrafish is a useful model for
xenotransplantation of human cancer cells and toxicity studies of different
chemotherapeutic compounds in vivo. Compared to the murine model, the zebrafish
model is **faster**, can be screened using **high-throughput methods** and has a **lower
maintenance cost**, making it possible and affordable to create personalized therapies.

While several methods for cell proliferation determination based on image acquisition
and quantification have been developed, some drawbacks still remain. In the
xenotransplantation technique, quantification of cellular proliferation in vivo is critical to
standardize the process for future preclinical applications of the model.

ZFtool can establish a base threshold that eliminates embryo auto-fluorescence and
measures the area of marked cells (GFP) and the intensity of those cells to define a
*proliferation index*.

## Usage

The images are classified within a **set**, then within an **experiment** and then within a **patient**, each hierarchically in **their own folder**, so images for the patient `VC` for experiment `E1` and set `Set1` will be inside the folder `Set1/E1/VC`. The format of images is the following, being `PP`the patient initials, `EE` the experiment, `d` the disk number, `c` the field number and `XXX` the layer number:
 * Green image, named `PP_EE_Dd_Cc_zXXX_green.tif`
 * Red image, named `PP_EE_Dd_Cc_zXXX_red.tif`

There is an example included in the repository, in the folder `Set1`:

```
Set1/E1/VC/VC_E1_D?C?_z???_green.tif
Set1/E1/VC/VC_E1_D?C?_z???_red.tif
Set1/E1/VQ/VQ_E1_D?C?_z???_green.tif
Set1/E1/VQ/VQ_E1_D?C?_z???_red.tif
```

With the included images you can run the following example:

 * Image folder: Set1
 * Experiment folder: E1
 * Patient folder: VC
 * Patient folder VQ