classdef fdtd
   properties
       E
       x
       y
       z
   end
   methods
       function obj=fdtd(data)
           re = sqrt(data.E(:,1).*conj(data.E(:,1)) + data.E(:,2).*conj(data.E(:,2)) + data.E(:,3).*conj(data.E(:,3)));
           obj.x = data.x .* 1e9;
           obj.y = data.y .* 1e9;
           obj.z = data.z .* 1e9;
           obj.E = reshape(re, length(data.x), length(data.y), length(data.z));
       end
       function ret=slice(obj, index)
           data = obj.E(:,:,index);
           ret=slice(data, obj.x, obj.y);
       end
       function slice=at(obj, z)
        [~, index] = min(abs(obj.z - z));
        slice = obj.slice(index);
       end
   end
end
