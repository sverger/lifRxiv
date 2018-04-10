//////////////////////////////////////////////////////////////////////////////////
///////////////////////////Conversion from .lif to .tif///////////////////////////
//////////////////////Stéphane Verger, Post-doc, 2015-05-10///////////////////////
//////////////////////////////////////////////////////////////////////////////////

//Before running the script put your .lif file in the folder of your choice.// 
//In the same folder, for each .lif file, create a sub-folder named as the .lif file// 


//Choose the directory containing your .lif file//
dir = getDirectory("Choose a directory")
setBatchMode(true);
list = getFileList(dir);

//Find .lif experiment//
for (FileInd=0; FileInd<list.length; FileInd++){
	FileName = list[FileInd];
	if(endsWith (FileName, "lif")){
		print ("### Processing ",FileName," ###");
		path = dir+FileName;

		//Open .lif//
		run("Bio-Formats Importer", "open=["+path+"] color_mode=Default view=Hyperstack stack_order=XYCZT use_virtual_stack open_all_series split_channels ");

//Saving as .tif the content of the .lif files, in their destination folders//
list = getList("image.titles");
		//get the name of each image opened//  
		ids=newArray(nImages);
		for (j=0; j<list.length; j++){
			//print(list[j]);
			selectImage(j+1);
			ids[j]=getTitle;
			//if (matches (ids[j], "TileScan")){
				//print (Tilescan);
			//}
			//tilescanname = substring(ids[j],0,-3);
			//print (tilescanname);
			//if (endsWith (ids[j], "tile")){
			//}
			name = ids[j];
			//print("file_name",name);

			//Get experiment name (title of the .lif file)//
			experiment_name=substring(ids[j],0,indexOf(ids[j],".lif"));
			//print("Experiment_title --> ",experiment_name);
			
			//Remove the name of the .lif file that is included in each image//
			short_name1 = substring(ids[j], indexOf(ids[j], "- "), lastIndexOf(ids[j], ""));
			//print("short_file_name1",short_name1);
			short_name = replace(short_name1, "- ", "");
			print("file_name --> ",short_name);
			
			//If not a stack, save directly as .tif with a short name//
			if (nSlices==1){
				print("Not a stack");
				saveAs("Tiff", dir+File.separator+experiment_name+File.separator+short_name);
				print(short_name, ">>> Image saved as .tif");
				
			//If a stack, reverse and save as .tif with a short name//
			} else {
				run("Reverse");
				saveAs("Tiff", dir+File.separator+experiment_name+File.separator+short_name);
				print(short_name, ">>> Reversed and saved as .tif");
				};
			};
		run("Close All");
		print("Done with", FileName,"!");
	} else {
	print("### ",FileName," Not a .lif file###");
	};
};	
print("Done with this folder!!!");




