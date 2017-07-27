function [] = chroma_image(chroma)
imagesc(chroma)
notes = {'A', 'A^#/B^b', 'B', 'C', 'C^#/D^b', 'D', 'D^#/E^b', 'E', 'F', 'F^#/G^b', 'G', 'G^#/A^b'};
set(gca, 'YTick', 1:12);
set(gca, 'YTickLabel', notes);