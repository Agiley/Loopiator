module XMLRPC
  class Create
    private
    
    def conv2value(param) # :doc:
        val = case param
        when Integer
          # XML-RPC's int is 32bit int
          if Config::ENABLE_BIGINT
            @writer.tag("int", param.to_s)
          else
            if param >= -(2**31) and param <= (2**31-1)
              @writer.tag("int", param.to_s)
            else
              raise "Integer is too big! Must be signed 32-bit integer!"
            end
          end
        when TrueClass, FalseClass
          @writer.tag("boolean", param ? "1" : "0")

        when Symbol
          @writer.tag("string", param.to_s)

        when String
          @writer.tag("string", param)

        when NilClass
          if Config::ENABLE_NIL_CREATE
            @writer.ele("nil")
          else
            raise "Wrong type NilClass. Not allowed!"
          end

        when Float
          raise "Wrong value #{param}. Not allowed!" unless param.finite?
          @writer.tag("double", param.to_s)

        when Struct
          h = param.members.collect do |key|
            value = param[key]
            @writer.ele("member",
              @writer.tag("name", key.to_s),
              conv2value(value)
            )
          end

          @writer.ele("struct", *h)

        when Hash
          # TODO: can a Hash be empty?

          h = param.collect do |key, value|
            @writer.ele("member",
              @writer.tag("name", key.to_s),
              conv2value(value)
            )
          end

          @writer.ele("struct", *h)

        when Array
          # TODO: can an Array be empty?
          a = param.collect {|v| conv2value(v) }

          @writer.ele("array",
            @writer.ele("data", *a)
          )

        when Time, Date, ::DateTime
          @writer.tag("dateTime.iso8601", param.strftime("%Y%m%dT%H:%M:%S"))

        when XMLRPC::DateTime
          @writer.tag("dateTime.iso8601",
            format("%.4d%02d%02dT%02d:%02d:%02d", *param.to_a))

        when XMLRPC::Base64
          @writer.tag("base64", param.encoded)

        else
          if Config::ENABLE_MARSHALLING and param.class.included_modules.include? XMLRPC::Marshallable
            # convert Ruby object into Hash
            ret = {"___class___" => param.class.name}
            param.instance_variables.each {|v|
              name = v[1..-1]
              val = param.instance_variable_get(v)

              if val.nil?
                ret[name] = val if Config::ENABLE_NIL_CREATE
              else
                ret[name] = val
              end
            }
            return conv2value(ret)
          else
            ok, pa = wrong_type(param)
            if ok
              return conv2value(pa)
            else
              raise "Wrong type!"
            end
          end
        end

        @writer.ele("value", val)
    end
  end # class Create
end # module XMLRPC
