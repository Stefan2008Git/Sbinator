package data.backend;

#if (cpp && windows)
@:headerInclude('windows.h')
@:headerInclude('psapi.h')
#elseif (cpp && linux)
@:cppFileCode("#include <stdio.h>")
#end

/**
 * Utility class with the ability to return the program's memory usage.
 */
class Memory {
    /**
     * Returns the amount of memory currently used by the program, in bytes.
     * On Windows, this returns the total amount of memory allocated by the process.
     * On other targets, this returns the amount of memory allocated by the garbage collector.
     */
    #if (cpp && windows)
    @:functionCode('
        PROCESS_MEMORY_COUNTERS_EX pmc;
        if (GetProcessMemoryInfo(GetCurrentProcess(), (PROCESS_MEMORY_COUNTERS*)&pmc, sizeof(pmc)))
            return pmc.WorkingSetSize;
    ')
    #end
    public static function getProcessUsage():Float {
        #if linux
        return getTotalRamForLinux();
        #else
        return openfl.system.System.totalMemoryNumber;
        #end
    }

    // Credits to CodenameCrew for RAM usage handlering
    #if linux
	@:functionCode('
		FILE *meminfo = fopen("/proc/meminfo", "r");

		if(meminfo == NULL)
			return -1;

		char line[256];
		while(fgets(line, sizeof(line), meminfo))
		{
			int ram;
			if(sscanf(line, "MemTotal: %d kB", &ram) == 1)
			{
				fclose(meminfo);
				return (ram / 1024);
			}
		}

		fclose(meminfo);
		return -1;
	')
	public static function getTotalRamForLinux():Float
	{
		return 0;
	}
	#end
}
