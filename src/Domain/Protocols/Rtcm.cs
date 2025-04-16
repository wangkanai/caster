// Copyright (c) 2014-2025 Sarin Na Wangkanai, All Rights Reserved.Apache License, Version 2.0

namespace Wangkanai.Caster.Domain.Protocols;

public class Rtcm
{
	private const byte _preamble = 0x66; // 01100110
	public const  int  n         = 32;
	public const  int  k         = 10;
	public const  int  d         = 4;

	private enum MessageType : int
	{
		DifferentialGpsCorrections   = 1,
		DeltaDifferentialCorrections = 2,
		ReferenceStationStatus       = 3,
		HighRateStationCorrections   = 9,
	}
}

public class Rtcm2 : Rtcm { }

public class Rtcm3 : Rtcm { }
