// Copyright (c) 2014-2025 Sarin Na Wangkanai, All Rights Reserved.Apache License, Version 2.0

using Microsoft.AspNetCore.Identity;

using Wangkanai.Caster.Data;

namespace Wangkanai.Caster.Application.Identity;

public static class UserSeed
{
	internal static List<CasterUser> Users =>
	[
		Create("sarin@wangkanai.com", "P@ssw0rd", "Sarin", "Na Wangkanai")
	];

	private static PasswordHasher<CasterUser> Hasher => new();

	private static CasterUser Create(string email, string password, string firstname, string lastname)
		=> new()
		   {
			   Id                 = Guid.NewGuid(),
			   Email              = email,
			   EmailConfirmed     = true,
			   UserName           = email,
			   NormalizedUserName = email.ToUpper(),
			   NormalizedEmail    = email.ToUpper(),
			   PasswordHash       = Hasher.HashPassword(null!, password),
			   SecurityStamp      = Guid.NewGuid().ToString(),
			   Firstname          = firstname,
			   Lastname           = lastname
		   };
}
