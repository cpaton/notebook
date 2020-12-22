using System.Collections.Generic;
using System.Linq;
using Statiq.Common;
using Statiq.Core;

namespace Notebook
{
    public static class Extensions
    {
        public static void UsePages(this IPipeline pipeline, bool withTree = false)
        {
            pipeline.Dependencies.Add(Pipelines.Pages);
            if (withTree) pipeline.Dependencies.Add(Pipelines.PageTree);
            pipeline.ProcessModules.Insert(0, new ReplaceDocuments(Pipelines.Pages));
        }

        public static void WriteHtml(this IPipeline pipeline)
        {
            pipeline.OutputModules.Add(
                new SetDestination(".html"),
                new WriteFiles());
        }

        public static IOrderedEnumerable<IDocument> RootDocuments(this IExecutionContext executionContext)
        {
            return executionContext.Outputs.FromPipeline(Pipelines.PageTree).OrderedByName();
        }

        public static IOrderedEnumerable<IDocument> OrderedByName(this IEnumerable<IDocument> documents)
        {
            return documents.OrderBy(x => x.TreePath()?.Last() ?? string.Empty);
        }

        public static IOrderedEnumerable<IDocument> Children(this IDocument parent)
        {
            return parent.Get<IEnumerable<IDocument>>(Keys.Children, new IDocument[] { }).OrderedByName();
        }

        public static string[] TreePath(this IDocument document)
        {
            return document.Get<string[]>(Keys.TreePath);
        }

        public static string LeafName(this IDocument document)
        {
            return document.TreePath().Last();
        }

        public static string Title(this IDocument document)
        {
            return document.Get<string>("Title");
        }

        public static string Url(this IDocument document)
        {
            return
                $"{document.Get<string>(SettingKeys.SiteBaseUrl)}/{document.Destination.GetRelativeInputPath().ToString().Replace(".md", ".html")}";
        }

        public static string SiteAssetsBaseUrl(this IDocument document)
        {
            return document.Get<string>(SettingKeys.SiteAssetsBaseUrl);
        }
    }
}