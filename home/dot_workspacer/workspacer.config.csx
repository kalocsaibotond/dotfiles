#r "C:\Users\botond.kalocsai\scoop\apps\workspacer\current\workspacer.Shared.dll"
#r "C:\Users\botond.kalocsai\scoop\apps\workspacer\current\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Users\botond.kalocsai\scoop\apps\workspacer\current\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Users\botond.kalocsai\scoop\apps\workspacer\current\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

using System;
using workspacer;
using workspacer.Bar;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;

Action<IConfigContext> doConfig = (context) =>
{
    // Uncomment to switch update branch (or to disable updates)
    //context.Branch = Branch.None;

    context.AddBar();
    context.AddFocusIndicator();
    var actionMenu = context.AddActionMenu();

    context.WorkspaceContainer.CreateWorkspaces(
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9"
    );
    context.CanMinimizeWindows = true; // false by default
};
return doConfig;
