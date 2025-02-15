import PackagePlugin

@main
struct AssetGenPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
    print("Running build tool [AssetGenPlugin]")
    let inputPath = context.package.directoryURL.appending(component: "Public")
    let outputPath = context.pluginWorkDirectoryURL.appending(component: "PublicAssets.swift", directoryHint: .notDirectory)
    return try [
      .prebuildCommand(
        displayName: "Static Asset Gen",
        executable: context.tool(named: "AssetGenCLI").url,
        arguments: [
          "--directory", inputPath.path(),
          "--output", outputPath.path(),
        ],
        outputFilesDirectory: context.pluginWorkDirectoryURL
      )
    ]
  }
}
