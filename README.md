# Neo Lib 

This library is just a pretty and clean way to load lua files for GMod server (also support client).
![Pretty loader exemple](https://octodex.github.com/images/yaktocat.png)

## How I implement it ?

- You have to create a loader in `autorun/` folder.
- Like to `autorun/loader.lua`.
- After that, move everything in `youraddonname/`
    - Also, create `youraddonname/sv/`, `youraddonname/sh/`, `youraddonname/cl/` (Keep it that way, even if there is no file in cl, sh or sv)


## Keep in mind

This addon is mainly for my personnal server. If you only need loader option only keep this `lib/sh/loader_util.lua`, you can get rid of anything else.
Also edit `autorun/loader.lua` and remove every include you don't need!