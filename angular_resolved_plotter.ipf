// Plots data from angular resolved setup
// written by Ben Isenhart (bisenhar@uvm.edu)

// To anyone trying to use and/or modify this code:
// This procedure file is a total mess, and really works just for the very specific case I made it
// for. It can certainly be adapted to work for different things, but it is going to require some
// effort from you. Even if you are just using it for plotting angular resolved data, be aware
// that it is designed specifically to work on folders with a .txt file for each spectrum, at 2.5
// degree intervals from 0 to 70 with no other .txt files in the folder. This is certainly not the
// most elegant thing I have ever written, so proceed with caution. To be honest, I just do
// not have the time or energy to make this program more general and elegant, but if you
// want to do some work to it, be my guest

Menu "Spectrometer"
	"Load Files/1", LoadFiles()
	"Make DataMatrix/2", PrepData()
	"Make Heatmap/3", MakeHeatmap()
	"Plot Forward Emission/4", MakeForwardEmission()
	"Do everything/5", LoadFiles();PrepData();MakeHeatmap();MakeForwardEmission()
End

// load all files and save in appropriate waves
Function/S LoadFiles()

	NewPath/O/M="Choose the folder you wish to plot data from" dataPath // opens up a dialog box
	Variable index = 0
	String extension=".txt"
	// note: this is the ascii alphabetal order of the wave names, so that the program loads them into the right waves
	String waveNames = "deg0;deg10;deg12pt5;deg15;deg17pt5;deg20;deg22pt5;deg25;deg27pt5;deg2pt5;deg30;deg32pt5;deg35;deg37pt5;deg40;deg42pt5;deg45;deg47pt5;deg50;deg52pt5;deg55;deg57pt5;deg5;deg60;deg62pt5;deg65;deg67pt5;deg70;deg7pt5;dark;"
	String fileName = IndexedFile(dataPath,index,extension)
	String thisWaveName = StringFromList(index,waveNames)
	String bString = "N='lambda';N='"+thisWaveName+"';" // needed for B flag of LoadWave command
	LoadWave/G/Q/P=dataPath/A/B=bString fileName
	// make another lambda wave that is one unit longer for use in making the heatmap
	Wave lambda,lambdaLong
	Duplicate lambda, lambdaLong
	Redimension/N=(numpnts(lambda)+1) lambdaLong
	lambdaLong[numpnts(lambda)] = lambda[numpnts(lambda)-1]+0.2 // 0.2 is approximation based on previous data points
	do // loop over all *.txt files in the chosen folder
		index++
		fileName=IndexedFile(dataPath,index,extension)
		if (strlen(fileName)==0)
			break
		endif
		thisWaveName = StringFromList(index,waveNames)
		bString = "N='_skip_';N='"+thisWaveName+"';" // needed for the B flag of the LoadWave command
		LoadWave/G/Q/P=dataPath/A/B=bString fileName
	while (1)
	
End

// make DataMatrix, Theta, and Lambda waves
Function/S PrepData()

	// make data matrix
	Make/N=(2068,29) dataMatrix
	// be warned: below is some horrifying hardcoded nonsense. I am sure there is an elegant solution to this, but 
	// I cannot think of it at this time and don't want to spend much time working on this. I have left the remains
	// of my attempt at an elegant solution below if anyone ever wants to take another stab at it
	String matrixWaveNames = "deg0;deg2pt5;deg5;deg7pt5;deg10;deg12pt5;deg15;deg17pt5;deg20;deg22pt5;deg25;deg27pt5;deg30;deg32pt5;deg35;deg37pt5;deg40;deg42pt5;deg45;deg47pt5;deg50;deg52pt5;deg55;deg57pt5;deg60;deg62pt5;deg65;deg67pt5;deg70;dark;"
	Wave deg0,deg2pt5,deg5,deg7pt5,deg10,deg12pt5,deg15,deg17pt5,deg20,deg22pt5,deg25,deg27pt5,deg30,deg32pt5,deg35,deg37pt5,deg40,deg42pt5,deg45,deg47pt5,deg50,deg52pt5,deg52pt5,deg55,deg57pt5,deg60,deg62pt5,deg65,deg67pt5,deg70,dark
	dataMatrix[][0]=deg0[p]-dark[p]
	dataMatrix[][1]=deg2pt5[p]-dark[p]
	dataMatrix[][2]=deg5[p]-dark[p]
	dataMatrix[][3]=deg7pt5[p]-dark[p]
	dataMatrix[][4]=deg10[p]-dark[p]
	dataMatrix[][5]=deg12pt5[p]-dark[p]
	dataMatrix[][6]=deg15[p]-dark[p]
	dataMatrix[][7]=deg17pt5[p]-dark[p]
	dataMatrix[][8]=deg20[p]-dark[p]
	dataMatrix[][9]=deg22pt5[p]-dark[p]
	dataMatrix[][10]=deg25[p]-dark[p]
	dataMatrix[][11]=deg27pt5[p]-dark[p]
	dataMatrix[][12]=deg30[p]-dark[p]
	dataMatrix[][13]=deg32pt5[p]-dark[p]
	dataMatrix[][14]=deg35[p]-dark[p]
	dataMatrix[][15]=deg37pt5[p]-dark[p]
	dataMatrix[][16]=deg40[p]-dark[p]
	dataMatrix[][17]=deg42pt5[p]-dark[p]
	dataMatrix[][18]=deg45[p]-dark[p]
	dataMatrix[][19]=deg47pt5[p]-dark[p]
	dataMatrix[][20]=deg50[p]-dark[p]
	dataMatrix[][21]=deg52pt5[p]-dark[p]
	dataMatrix[][22]=deg55[p]-dark[p]
	dataMatrix[][23]=deg57pt5[p]-dark[p]
	dataMatrix[][24]=deg60[p]-dark[p]
	dataMatrix[][25]=deg62pt5[p]-dark[p]
	dataMatrix[][26]=deg65[p]-dark[p]
	dataMatrix[][27]=deg67pt5[p]-dark[p]
	dataMatrix[][28]=deg70[p]-dark[p]
//	Variable index
//	for (index=0; index<30; index++)
//		String thisWaveName = StringFromList(index,matrixWaveNames)
//		Wave/Z tmpWave = $thisWaveName
//		dataMatrix[][index] = tmpWave
//	endFor

	// make theta wave (note: is one unit longer than you might expect for making the heatmap)
	Make/N=29 theta={0,2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,27.5,30,32.5,35,37.5,40,42.5,45,47.5,50,52.5,55,57.5,60,62.5,65,67.5,70,72.5}
	
End

// make heatmap from DataMatrix
Function/S MakeHeatmap()

	Wave dataMatrix,theta,lambdaLong
	Display; DelayUpdate
	AppendImage dataMatrix vs {lambdaLong,theta}
	ModifyImage dataMatrix ctab={*,*,yellowhot,0} // set colorscheme
	SetAxis bottom 450,650

End	

// make graph of forward emission
Function/S MakeForwardEmission()

	Wave deg0,lambda,dark
	Make/N=2068 deg0Scaled
	deg0Scaled[]=deg0[p]-dark[p]
	Display deg0Scaled vs lambda
	SetAxis bottom 450,650
	
End
