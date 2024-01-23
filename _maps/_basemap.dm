#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\Theseus\Theseus.dmm"
		#include "map_files\AegisVII\AegisVII_Low.dmm"
		#include "map_files\AegisVII\AegisVII_Middle.dmm"
		#include "map_files\AegisVII\AegisVII_High.dmm"
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
