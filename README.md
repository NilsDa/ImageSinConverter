# ImageSinConverter

This repository contains Matlab scripts to process an arbitrary Image file into a representation with sine waves.

## important files

- ImageSinConverter.m -> first version of this. Result looks not very nice.
- ImageSinConverter_V2.m -> alternative version with different calculatinos and much nicer result. (However, still room for improvements/additional filtering...)
  - What happens: convert to grayscale -> apply edge detection -> apply entropy filter (3 different filters implemented) -> reduce number of rows (increase row sice) -> calculate sine waves (one for each row)
- SinRow.m -> function which calculates the sine waves for each row of the final picture. Uses lots of manual calculations because I wanted to figure something out without outside help. Main problem turned out to be the generation of a continuous wave with variable frequency without "jumps" (i.e. calculating "jumps" in the sine phase in a way that avoids "jumps" in the final signal).

I feel like my SinRow.m function results in "ok" signals. However, I have seen better results (on the internet). Also: result heavily depends on the picture.
Still, good image processing practice :).

A way to improve upon this would be to use wavelet transformation to calculate frequencies for different areas of the picture (which can then be subject to further filtering). This would heavily simplify certain calculation that are done manually right now. However, it would not avoid the main problem with "jumps" in the signal.
