# ImageSinConverter

This repository contains Matlab scripts to process an arbitrary Image file into a representation with sine waves.

## important files

- ImageSinConverter.m -> first version of this. Result looks not very nice.
- ImageSinConverter_V2.m -> alternative version with different calculatinos and much nicer result. (However still room for improvements/additional filtering...)
- SinRow.m -> function which calculates the sine waves for each row of the final picture. Uses lots of manual calculations because I wanted to figure something out without outside help. Main problem turned out to generate a continuous wave with variable frequency without "jumps".

I feel like my SinRow.m function results in "ok" signals. However I have seen better results (on the internet).
