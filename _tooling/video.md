---
title: Video
---

### Splitting large files

Run the command to ffmpeg to open the file and output information e.g. how long it is

```
docker run -v /c/_cp/temp:/tmp/ffmpeg opencoconut/ffmpeg -i '/tmp/ffmpeg/Live Six Nations Rugby-Italy v Wales-1300-20170205.ts'
```

Then to split it into multiple smaller files

```
docker run -v /c/_cp/temp:/tmp/ffmpeg opencoconut/ffmpeg -i '/tmp/ffmpeg/Live Six Nations Rugby-Italy v Wales-1300-20170205.ts' -vcodec copy -acodec copy -ss 00:00:00 -t 01:30:00 -sn 'Part 1.ts' -vcodec copy -acodec copy -ss 01:30:00 -t 03:20:55 -sn 'Part 2.ts'
```