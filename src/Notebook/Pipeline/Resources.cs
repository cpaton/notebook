using Statiq.Common;
using Statiq.Core;

namespace Notebook.Pipeline
{
    /// <summary>
    ///     Copies Javascript and css resources into the output
    /// </summary>
    public class Resources : Statiq.Core.Pipeline, INamedPipeline
    {
        public Resources()
        {
            InputModules.Add(new ReadFiles("css/*.css", "js/*.js"));
            OutputModules.Add(new WriteFiles());
        }

        public string PipelineName => Pipelines.Resources;
    }
}