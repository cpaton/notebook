using Statiq.App;
using Statiq.Common;

namespace Notebook
{
    public static class Settings
    {
        public static Bootstrapper NotebookSettings(this Bootstrapper bootstrapper)
        {
            return bootstrapper
                .AddSetting(SettingKeys.SiteTitle, "Notebook")
                .AddSetting(SettingKeys.SiteUrl, "https://nb.craigpaton.uk")
                .AddSetting(SettingKeys.SiteBaseUrl, string.Empty)
                .AddSetting(SettingKeys.SiteAssetsBaseUrl, "https://assets.nb.craigpaton.uk/files")
                .AddSetting(SettingKeys.SiteDescription, "Programmers Notebook");
        }
    }
}