classdef map
   properties
       values
       scale
   end
   methods
       function obj = map(name, scale)
          image = double(imread(name));
          if ndims(image) == 3
            image = 0.2989 * image(:,:,1) + 0.5870 * image(:,:,2) + 0.1140 * image(:,:,3);
          end
          image = image';
          max_value = max(reshape(image, 1, []));
          obj.values = image ./ max_value;
          obj.scale = scale;
       end

       function draw(obj)
          colormap('gray');
          h = surf(obj.values .* obj.scale);
          set(h,'LineStyle','none');
       end

       function height = height(obj, x, y)
          height = obj.values(x, y) * obj.scale;
       end
   end
end
