classdef slice
   properties
       E
       x
       y
   end
   methods
       function obj=slice(E, x, y)
           obj.E = E;
           obj.x = x;
           obj.y = y;
       end
       
       function draw(obj)
           surf(obj.mirror);
       end
       
       function plot_y(obj)
          data = obj.E(:, length(obj.y));
          data = data ./ obj.max * 100;
          data = [data; flipud(data)];
          plot(data);
       end
       
       function data=mirror(obj)
           colormap('hot');
           data = [obj.E fliplr(obj.E)];
           data = [data; flipud(data)];
       end
       
       function value=average(obj)
           value = mean(reshape(obj.E, 1, [])) / obj.min;
       end
       
       function val=values(obj)
           val = reshape(obj.E, 1, [])';
       end
       
       function val=min(obj)
           val = min(obj.values);
       end
       
       function val=max(obj)
           val = max(obj.values);
       end
       
       function val=x_span(obj)
           val = abs(min(obj.x) - max(obj.x));
       end
       
       function val=y_span(obj)
           val = abs(min(obj.y) - max(obj.y));
       end
       
       function val=extrapolate(obj, radius)
           base_area = radius * radius * 0.25 * pi;
           area = obj.x_span * obj.y_span;
           missing_area = base_area - area;
           val = (area * obj.average + missing_area * obj.min) / base_area;
       end
   end
end