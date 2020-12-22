using System;
using Statiq.Common;
using Statiq.Core;

namespace Notebook.Pipeline
{
    /// <summary>
    ///     Converts the flat list of markdown documents into documents with a tree structure - each document has a Children
    ///     property
    /// </summary>
    public class PageTree : Statiq.Core.Pipeline, INamedPipeline
    {
        public PageTree()
        {
            this.UsePages();
            ProcessModules.Add(
                new CreateTree().WithNesting(true, true).WithSort(TitleAlphabeticalOrder));
        }

        public string PipelineName => Pipelines.PageTree;

        public static int TitleAlphabeticalOrder(IDocument lhs, IDocument rhs, IExecutionContext context)
        {
            var lhsPath = lhs.Source.GetRelativeInputPath().Parent.FullPath;
            var rhsPath = rhs.Source.GetRelativeInputPath().Parent.FullPath;

            var pathComparison = string.Compare(lhsPath, rhsPath, StringComparison.OrdinalIgnoreCase);
            if (pathComparison != 0) return pathComparison;

            var lhsTitle = lhs.Get<string>("Title");
            var rhsTitle = rhs.Get<string>("Title");

            return string.Compare(lhsTitle, rhsTitle, StringComparison.OrdinalIgnoreCase);
        }
    }
}