//////////////////////////////////////////////////////////////////////////////////
////////////////////////////ArchiveLIFfilesMultiFolder////////////////////////////
//////////////////////Stéphane Verger, Post-doc, 2017-11-08///////////////////////
//////////////////////////////////////////////////////////////////////////////////

//Before running the macro put .lif files in a folder, 
//and put all the folders in a common folder that you will select at the begining when running the macro// 
//This macro will create 2 files named as you .lif file:
//	- A .txt file with the liste of all the images contained in the .lif file
//	- A .tiff file containing a mosaic of all the images contained in the .lif file.
//		- In case of a Z-Stack the stack is "max-intensity-projected"
//		(- In case of a time serie, the stack is "color coded projected")
//		(- In case of a hyperstack Z-stack/time serie, the stack is first "Z-projected" and the "color code projected")

/////For processing multiple folders/////
//Choose the directory containing your .lif file//
dir0 = getDirectory("Choose a directory")
setBatchMode(true);
list0 = getFileList(dir0);
for (FoldInd=0; FoldInd<list0.length;FoldInd++){
	dir = dir0 + list0[FoldInd];
	list = getFileList(dir);

//Find .lif experiment//
for (FileInd=0; FileInd<list.length; FileInd++){
	FileName = list[FileInd];
	if(endsWith (FileName, "lif")){
		print ("### Processing ",FileName," ###");
		path = dir+FileName;
		ShortFileName =  substring(FileName,0,indexOf(FileName,".lif"));

		//Open .lif//
		run("Bio-Formats Importer", "open=["+path+"] color_mode=Default view=Hyperstack stack_order=XYCZT use_virtual_stack open_all_series split_channels ");
		//Z-Project
		list3 = getList("image.titles");
		f = File.open(dir+File.separator+ShortFileName+".txt");
		for (j=0; j<list3.length; j++){
			selectImage(j+1);
			preshortname = substring(list3[j], indexOf(list3[j], "- "), lastIndexOf(list3[j], ""));
			Shortname = replace(preshortname, "- ", "");
			print(f, Shortname);
			rename(Shortname);
			if (nSlices>1){
				print("Z-Projecting"+list3[j]);
				run("Z Project...", "projection=[Max Intensity]");
			};
		};
		//Create and save montage
		run("Images to Stack", "name=Stack title=[] use");
		run("Make Montage...", "columns=[] rows=[] scale=0.25 label use");
		saveAs("Tiff", dir+File.separator+ShortFileName);
		run("Close All");
		File.close(f);
		print("Done with", FileName,"!");
	} else {
	print("### ",FileName," Not a .lif file###");
	};
};	
print("Done with this folder!!!");
};
print("___Done___");
