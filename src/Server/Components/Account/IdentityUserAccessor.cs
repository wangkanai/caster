// Copyright (c) 2014-2025 Sarin Na Wangkanai, All Rights Reserved.Apache License, Version 2.0

using Microsoft.AspNetCore.Identity;
using Wangkanai.Caster.Identity;

namespace Wangkanai.Caster.Components.Account;

internal sealed class IdentityUserAccessor(UserManager<CasterUser> userManager, IdentityRedirectManager redirectManager)
{
    public async Task<CasterUser> GetRequiredUserAsync(HttpContext context)
    {
        var user = await userManager.GetUserAsync(context.User);

        if (user is null)
        {
            redirectManager.RedirectToWithStatus("Account/InvalidUser", $"Error: Unable to load user with ID '{userManager.GetUserId(context.User)}'.", context);
        }

        return user;
    }
}
