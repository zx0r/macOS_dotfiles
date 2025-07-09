# Make VSCodium use the VS Code marketplace
# if test -x (command -q codium)
#     set -gx VSCODE_GALLERY_SERVICE_URL 'https://marketplace.visualstudio.com/_apis/public/gallery'
#     set -gx VSCODE_GALLERY_CACHE_URL 'https://vscode.blob.core.windows.net/gallery/index'
#     set -gx VSCODE_GALLERY_ITEM_URL 'https://marketplace.visualstudio.com/items'
#     set -gx VSCODE_GALLERY_CONTROL_URL ''
#     set -gx VSCODE_GALLERY_RECOMMENDATIONS_URL ''
# end

# function switch_gallery
#     if test "$argv[1]" = default
#         set -gx VSCODE_GALLERY_SERVICE_URL "https://marketplace.visualstudio.com/_apis/public/gallery"
#         set -gx VSCODE_GALLERY_ITEM_URL "https://marketplace.visualstudio.com/items"
#         set -gx VSCODE_GALLERY_CACHE_URL "https://vscode.blob.core.windows.net/gallery/index"
#     else if test "$argv[1]" = openvsx
#         set -gx VSCODE_GALLERY_SERVICE_URL "https://open-vsx.org/vscode/gallery"
#         set -gx VSCODE_GALLERY_ITEM_URL "https://open-vsx.org/vscode/item"
#         set -gx VSCODE_GALLERY_CACHE_URL "https://open-vsx.org/vscode/cache"
#     else
#         echo "Usage: switch_gallery [default|openvsx]"
#     end
# end

# if command -q codium
#     launchctl unsetenv VSCODE_GALLERY_SERVICE_URL
#     launchctl unsetenv VSCODE_GALLERY_CACHE_URL
#     launchctl unsetenv VSCODE_GALLERY_ITEM_URL
#     launchctl setenv VSCODE_GALLERY_SERVICE_URL 'https://marketplace.visualstudio.com/_apis/public/gallery'
#     launchctl setenv VSCODE_GALLERY_CACHE_URL 'https://vscode.blob.core.windows.net/gallery/index'
#     launchctl setenv VSCODE_GALLERY_ITEM_URL 'https://marketplace.visualstudio.com/items'
#     #     # launchctl setenv VSCODE_GALLERY_CONTROL_URL ''
#     #     # launchctl setenv VSCODE_GALLERY_RECOMMENDATIONS_URL ''
# end

# function switch_gallery
#     if test "$argv[1]" = ms
#         launchctl setenv VSCODE_GALLERY_SERVICE_URL "https://marketplace.visualstudio.com/_apis/public/gallery"
#         launchctl setenv VSCODE_GALLERY_ITEM_URL "https://marketplace.visualstudio.com/items"
#         launchctl setenv VSCODE_GALLERY_CACHE_URL "https://vscode.blob.core.windows.net/gallery/index"
#     else if test "$argv[1]" = openvsx
#         launchctl setenv VSCODE_GALLERY_SERVICE_URL "https://open-vsx.org/vscode/gallery"
#         launchctl setenv VSCODE_GALLERY_ITEM_URL "https://open-vsx.org/vscode/item"
#         launchctl setenv VSCODE_GALLERY_CACHE_URL "https://open-vsx.org/vscode/cache"
#     else
#         echo "Usage: switch_gallery [ms|openvsx]"
#     end
# end

# launchctl getenv VSCODE_GALLERY_SERVICE_URL
# launchctl getenv VSCODE_GALLERY_CACHE_URL
# launchctl getenv VSCODE_GALLERY_ITEM_URL
# launchctl getenv VSCODE_GALLERY_CONTROL_URL
# launchctl getenv VSCODE_GALLERY_RECOMMENDATIONS_URL
