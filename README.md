# lifRxiv
Small scripts to: 
- extract and save images from .lif files (Leica confocal microscope file format) into .tif file
- create a montage image (single image made of vignettes) of all the images contained in a .lif file, as well as a text file containing all the names of the images contained in the .lif file. 

The goal is to allow a compression of the .lif files (for exemple in .zip) to reduce disk space use and still have a quick acces (preview) to the file content without having to un compress them.

With all the text files you can create a simple "database"./
For this, in a terminal go to the directory containing all the .txt files and type :
    
    more *.txt > Database.txt
    
This will create a new text file containing all the names and contents of the .txt files present in the folder.
You can then simply search all your images in this "Database.txt" file by keyword contained in the image or the .lif file name.
