using Statiq.Common;
using Statiq.Core;

namespace Notebook.Pipeline
{
    /// <summary>
    ///     Copies files used by GihHub pages
    /// </summary>
    public class GitHubPages : Statiq.Core.Pipeline, INamedPipeline
    {
        public GitHubPages()
        {
            InputModules.Add(new ReadFiles("CNAME", ".nojekyll"));
            OutputModules.Add(new WriteFiles());
        }

        public string PipelineName => Pipelines.GitHubPages;
    }
}