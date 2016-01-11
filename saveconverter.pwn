#include <a_samp>
#include <sscanf2>

#define CONVERT_ANGLE

#define A_CLASS 		sscanf(buffer, "p<,>'AddPlayerClass('{d}ffff{s[64]}", X, Y, Z, A)
#define A_VEHICLE		sscanf(buffer, "p<,>'AddStaticVehicle('{d}ffff{s[64]}", X, Y, Z, A)
#define A_VEHICLE_EX    sscanf(buffer, "p<,>'AddStaticVehicleEx('{d}ffff{s[64]}", X, Y, Z, A)
#define C_VEHICLE       sscanf(buffer, "p<,>'CreateVehicle('{d}ffff{s[64]}", X, Y, Z, A)


public OnFilterScriptInit()
{
	print("\n----------------------------------");
	print("Gangzone Creator v1.0 by IntrozeN");
	print("----------------------------------\n");

	new
		File:fSavefile = fopen("savedpositions.txt", io_read),
		File:fOutput = fopen("f_savedpositions.txt", io_write),
		buffer[256],
		Float:X, Float:Y, Float:Z, Float:A,
		t1, t2,
		i;

	t1 = GetTickCount();
	while(fread(fSavefile, buffer))
	{
		i++;
		if(A_CLASS && A_VEHICLE && A_VEHICLE_EX && C_VEHICLE)
		{
			printf("Invalid line: %d", i);
			continue;
		}
		
		//printf("%f, %f, %f, %f,", X, Y, Z, A);

		#if defined CONVERT_ANGLE
		format(buffer, sizeof(buffer), "{%.4f,%.4f,%.4f,%.4f},\n", X, Y, Z, A);
		#else
		format(buffer, sizeof(buffer), "{%.4f,%.4f,%.4f},", X, Y, Z);
		#endif
		fwrite(fOutput, buffer);

	}
	fclose(fSavefile);
	fclose(fOutput);

	t2 = GetTickCount();
	printf("%d pos converted in %d ms!", i, t2 - t1);
	return 1;
}

