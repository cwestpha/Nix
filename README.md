# Nix
Fun package repo of my nix /w Framework 12th gen laptop

This is quite a WiP. When this is done there will be two version:
Keep it Simple Stupid template & Example
Flake Running Config [example of a Flake structure that I use]
Flake Template with instructions [aka clone me and go through the instructions on building your own flake basesed NixOS]

Why is this a little different?

Nix is a kind of cool concept but has a huge learning curve. The main issue I have is that NIX is quite by coders for coders. However as someone who has to support coders I also know they drive me nuts and I drive them nuts.
My End User Computing (EUC) perspective is different and there are some things that they seem to not understand in the mind of most coder's because they have completely different objectives in what they are trying to acomplish then I do.

So here is why its different:
1) Users just want things to work, they dont care how it does.
2) Once they have a minimal working enviornment they start feeling comfortable enough to start expanding on the foundation you set for them.
3) Make sure your foundation is documented well and reproducable. If you DIFF into a another methodology without explanation and hand holding they will table flip.


So the basis of this little project is as follows:
Help the user install NixOS on a Framework Laptop using the current build of NixOS.

Such an OS should be:
A) secureboot enabled, signed, and encrypted 'out of the box'
B) Using disk encryption fronted by TPM2 for auto unlock.
C) Use the latest Desktop technologies like Wayland, Pipewire, etc to provide a good enough experiance that is being worked on and activly expanded on.
D) Use the Gnome DE with a minimal set of packages with a few tailored customizations and added apps to help the user acomplish a few basic tasks and research wahts next
E) Provide a few post build examples on how to do things like...
  *Search for and Add Packages (both NIX and Flatpak)
  *Be able to help keep their OS and system up to date and patched
  *link to good resources for doing specific common tasks.
