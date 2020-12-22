using Statiq.Common;
using Statiq.Core;
using Statiq.Markdown;
using Statiq.Razor;

namespace Notebook.Pipeline
{
    /// <summary>
    ///     Converts the markdown documents into HTML using a Razor page to provide the surrounding document e.g. the
    ///     header containing the full menu of links
    /// </summary>
    public class Render : Statiq.Core.Pipeline, INamedPipeline
    {
        public Render()
        {
            this.UsePages(true);
            ProcessModules.Add(
                new RenderMarkdown().UseExtensions(),
                new ReplaceInContent(SettingKeys.SiteAssetsBaseUrl, (_, document) => document.SiteAssetsBaseUrl()),
                new RenderRazor().WithLayout("/Shared/_page.cshtml"));
            this.WriteHtml();
        }

        public string PipelineName => Pipelines.Render;
    }
}