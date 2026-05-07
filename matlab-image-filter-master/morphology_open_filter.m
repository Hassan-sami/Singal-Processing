function gr = morphology_open_filter(image)
    gr = morphology_dilate_filter(morphology_erode_filter_with_se(image));
end
