import{_ as s,o as n,c as a,e as l}from"./app.08d28afd.js";const e={},i=l(`<h1 id="all-commands" tabindex="-1"><a class="header-anchor" href="#all-commands" aria-hidden="true">#</a> All Commands</h1><blockquote><p>Hi, we&#39;ve recently migrated our docs and added some new pages. If you would like to help translate this page, see the &quot;Edit this page&quot; link at the bottom of the page.</p></blockquote><p>A lista de todos os comandos disponíveis em <code>asdf</code>. Esta lista é o texto do comando <code>asdf help</code>.</p><div class="language-txt line-numbers-mode" data-ext="txt"><pre class="shiki" style="background-color:#272822;"><code><span class="line"><span style="color:#F8F8F2;">MANAGE PLUGINS</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf plugin add &lt;name&gt; [&lt;git-url&gt;]      Add a plugin from the plugin repo OR,</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        add a Git repo as a plugin by</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        specifying the name and repo url</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf plugin list [--urls] [--refs]      List installed plugins. Optionally show</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        git urls and git-ref</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf plugin list all                    List plugins registered on asdf-plugins</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        repository with URLs</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf plugin remove &lt;name&gt;               Remove plugin and package versions</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf plugin update &lt;name&gt; [&lt;git-ref&gt;]   Update a plugin to latest commit on</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        default branch or a particular git-ref</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf plugin update --all                Update all plugins to latest commit on</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        default branch</span></span>
<span class="line"><span style="color:#F8F8F2;"></span></span>
<span class="line"><span style="color:#F8F8F2;"></span></span>
<span class="line"><span style="color:#F8F8F2;">MANAGE PACKAGES</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf current                            Display current version set or being</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        used for all packages</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf current &lt;name&gt;                     Display current version set or being</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        used for package</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf global &lt;name&gt; &lt;version&gt;            Set the package global version</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf global &lt;name&gt; latest[:&lt;version&gt;]   Set the package global version to the</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        latest provided version</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf help &lt;name&gt; [&lt;version&gt;]            Output documentation for plugin and tool</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf install                            Install all the package versions listed</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        in the .tool-versions file</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf install &lt;name&gt;                     Install one tool at the version</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        specified in the .tool-versions file</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf install &lt;name&gt; &lt;version&gt;           Install a specific version of a package</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf install &lt;name&gt; latest[:&lt;version&gt;]  Install the latest stable version of a</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        package, or with optional version,</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        install the latest stable version that</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        begins with the given string</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf latest &lt;name&gt; [&lt;version&gt;]          Show latest stable version of a package</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf latest --all                       Show latest stable version of all the</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        packages and if they are installed</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf list &lt;name&gt; [version]              List installed versions of a package and</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        optionally filter the versions</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf list all &lt;name&gt; [&lt;version&gt;]        List all versions of a package and</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        optionally filter the returned versions</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf local &lt;name&gt; &lt;version&gt;             Set the package local version</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf local &lt;name&gt; latest[:&lt;version&gt;]    Set the package local version to the</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        latest provided version</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf shell &lt;name&gt; &lt;version&gt;             Set the package version to</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        \`ASDF_\${LANG}_VERSION\` in the current shell</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf uninstall &lt;name&gt; &lt;version&gt;         Remove a specific version of a package</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf where &lt;name&gt; [&lt;version&gt;]           Display install path for an installed</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        or current version</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf which &lt;command&gt;                    Display the path to an executable</span></span>
<span class="line"><span style="color:#F8F8F2;"></span></span>
<span class="line"><span style="color:#F8F8F2;"></span></span>
<span class="line"><span style="color:#F8F8F2;">UTILS</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf exec &lt;command&gt; [args...]           Executes the command shim for current version</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf env &lt;command&gt; [util]               Runs util (default: \`env\`) inside the</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        environment used for command shim execution.</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf info                               Print OS, Shell and ASDF debug information.</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf reshim &lt;name&gt; &lt;version&gt;            Recreate shims for version of a package</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf shim-versions &lt;command&gt;            List the plugins and versions that</span></span>
<span class="line"><span style="color:#F8F8F2;">                                        provide a command</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf update                             Update asdf to the latest stable release</span></span>
<span class="line"><span style="color:#F8F8F2;">asdf update --head                      Update asdf to the latest on the master branch</span></span>
<span class="line"><span style="color:#F8F8F2;"></span></span>
<span class="line"><span style="color:#F8F8F2;">RESOURCES</span></span>
<span class="line"><span style="color:#F8F8F2;">GitHub: https://github.com/asdf-vm/asdf</span></span>
<span class="line"><span style="color:#F8F8F2;">Docs:   https://asdf-vm.com</span></span>
<span class="line"><span style="color:#F8F8F2;"></span></span></code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div>`,4),t=[i];function p(o,c){return n(),a("div",null,t)}const d=s(e,[["render",p],["__file","commands.html.vue"]]);export{d as default};
