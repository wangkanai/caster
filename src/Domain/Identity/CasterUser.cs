// Copyright (c) 2014-2025 Sarin Na Wangkanai, All Rights Reserved.Apache License, Version 2.0

using Microsoft.AspNetCore.Identity;

namespace Wangkanai.Caster.Identity;

// Add profile data for application users by adding properties to the ApplicationUser class
public sealed class CasterUser : IdentityUser<Guid>
{
	public string? Firstname { get; set; }
	public string? Lastname  { get; set; }
	public string? Fullname  => $"{Firstname} {Lastname}";
}
