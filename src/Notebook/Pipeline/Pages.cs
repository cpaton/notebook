using Statiq.Common;
using Statiq.Core;
using Statiq.Yaml;

namespace Notebook.Pipeline
{
    /// <summary>
    ///     Collects all markdown documents and extracts their front matter
    ///     Attaches a canonical URL to all documents
    /// </summary>
    public class Pages : Statiq.Core.Pipeline, INamedPipeline
    {
        public Pages()
        {
            InputModules.Add(new ReadFiles(@"**\*.md"));
            ProcessModules.Add(
                new ExtractFrontMatter(new ParseYaml()),
                new CanonicalUrl());
        }

        public string PipelineName => Pipelines.Pages;
    }
}