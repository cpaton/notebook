namespace Notebook
{
    public static class Pipelines
    {
        public const string PageTree = "PageTree";
        public const string Pages = "Pages";
        public const string Render = "RenderPages";
        public const string Resources = "Resources";
        public const string GitHubPages = "GitHubPages";
        public const string FrontPage = "FrontPage";
    }

    public static class SettingKeys
    {
        public static readonly string SiteUrl = "site.url";
        public static readonly string SiteTitle = "site.title";
        public static readonly string SiteBaseUrl = "site.base-url";
        public static readonly string SiteAssetsBaseUrl = "site.asset-base-url";
        public static readonly string SiteDescription = "site.description";
        public static readonly string ConnonicalUrl = "CanonicalUrl";
    }
}