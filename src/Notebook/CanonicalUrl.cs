using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Statiq.Common;

namespace Notebook
{
    /// <summary>
    ///     Attaches a property with the canonical URL for the output document
    /// </summary>
    public class CanonicalUrl : Module
    {
        protected override Task<IEnumerable<IDocument>> ExecuteInputAsync(IDocument input, IExecutionContext context)
        {
            var relativePath = input.Source.GetRelativeInputPath();
            var siteUrl = input.Get<string>(SettingKeys.SiteUrl);
            var canonicalUrl = new Uri(new Uri(siteUrl),
                relativePath.FullPath.Replace(".md", ".html").Replace(".cshtml", ".html"));
            var updatedDocument = input.Clone(new[]
            {
                new KeyValuePair<string, object>(SettingKeys.ConnonicalUrl, canonicalUrl)
            });
            return Task.FromResult<IEnumerable<IDocument>>(new[] {updatedDocument});
        }
    }
}