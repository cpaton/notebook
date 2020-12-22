using Statiq.Common;
using Statiq.Core;
using Statiq.Razor;

namespace Notebook.Pipeline
{
    /// <summary>
    ///     Produces the index.html front page which has links to all of the content.
    ///     Output is generated from a Razor page which uses the generated PageTree information
    /// </summary>
    public class FrontPage : Statiq.Core.Pipeline, INamedPipeline
    {
        public FrontPage()
        {
            Dependencies.Add(Pipelines.PageTree);
            InputModules.Add(new ReadFiles("**/{!_,}*.cshtml"));
            ProcessModules.Add(
                new CanonicalUrl(),
                new RenderRazor().WithLayout("/Shared/_default.cshtml"));
            this.WriteHtml();
        }

        public string PipelineName => Pipelines.FrontPage;
    }
}