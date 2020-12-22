using System.Threading.Tasks;
using Statiq.App;

namespace Notebook
{
    internal class Program
    {
        public static async Task<int> Main(string[] args)
        {
            return await Bootstrapper.Factory
                .CreateDefault(args)
                .NotebookSettings()
                .RunAsync();
        }
    }
}