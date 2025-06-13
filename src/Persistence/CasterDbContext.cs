// Copyright (c) 2014-2025 Sarin Na Wangkanai, All Rights Reserved.Apache License, Version 2.0

using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace Wangkanai.Caster.Data;

public sealed class CasterDbContext(DbContextOptions<CasterDbContext> options)
	: IdentityDbContext<CasterUser, CasterRole, Guid>(options)
{
}
