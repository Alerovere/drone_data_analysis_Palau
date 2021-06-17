library(rayshader)
library(sp)
library(raster)
library(scales)

# Thanks: https://www.tylermw.com/a-step-by-step-guide-to-making-3d-maps-with-satellite-imagery-in-r/

#Both ortophoto and DEM must be in UTM coordinates.

elevation = raster::raster("TinyGiantClam_DEM.tif")

height_shade(raster_to_matrix(elevation)) %>%
  plot_map()


red_orto = raster::raster("TinyGiantClam_Orto.tif",band = 1)
green_orto = raster::raster("TinyGiantClam_Orto.tif",band = 2)
blue_orto = raster::raster("TinyGiantClam_Orto.tif",band = 3)

rgb_image = raster::stack(red_orto, green_orto, blue_orto)

bottom_left = c(y=134.4979725, x=7.3250900)
top_right   = c(y=134.4980540, x=7.3252577)

extent_latlong = sp::SpatialPoints(rbind(bottom_left, top_right), proj4string=sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84"))
extent_utm = sp::spTransform(extent_latlong, raster::crs(elevation))

e = raster::extent(extent_utm)

rgb_cropped = raster::crop(rgb_image, e)

elevation_cropped = raster::crop(elevation, e)

names(rgb_cropped) = c("r","g","b")

r_cropped = rayshader::raster_to_matrix(rgb_cropped$r)
g_cropped = rayshader::raster_to_matrix(rgb_cropped$g)
b_cropped = rayshader::raster_to_matrix(rgb_cropped$b)

el_matrix = rayshader::raster_to_matrix(elevation_cropped)

rgb_array = array(0,dim=c(nrow(r_cropped),ncol(r_cropped),3))

rgb_array[,,1] = r_cropped/255 #Red layer
rgb_array[,,2] = g_cropped/255 #Blue layer
rgb_array[,,3] = b_cropped/255 #Green layer

rgb_array = aperm(rgb_array, c(2,1,3))

rgb_contrast = scales::rescale(rgb_array,to=c(0,1))

plot_3d(rgb_array, el_matrix, zscale=0.01, windowsize = c(1100,900),
        water=TRUE,wateralpha=0.1,waterlinecolor='cadetblue')

render_camera(theta = 220, phi = 20, zoom=0.7,fov=70)
render_snapshot('3d_render.jpg')



