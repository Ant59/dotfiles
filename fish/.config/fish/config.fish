if status is-login
    if test (tty) = /dev/tty1
        sway
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/antony/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/antony/Downloads/google-cloud-sdk/path.fish.inc'; end
