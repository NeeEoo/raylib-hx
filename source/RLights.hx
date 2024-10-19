/**
 *   raylib-hx - a Haxe binding for the library raylib, a simple and easy-to-use library to enjoy videogames programming
 *
 *   LICENSE: zlib/libpng
 *
 *   raylib-hx is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
 *   BSD-like license that allows static linking with closed source software:
 *
 *   Copyright (c) 2021-2022 Ratul Krisna (@ForeignSasquatch)
 *
 *   This software is provided "as-is", without any express or implied warranty. In no event
 *   will the authors be held liable for any damages arising from the use of this software.
 *
 *   Permission is granted to anyone to use this software for any purpose, including commercial
 *   applications, and to alter it and redistribute it freely, subject to the following restrictions:
 *
 *     1. The origin of this software must not be misrepresented; you must not claim that you
 *     wrote the original software. If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but is not required.
 *
 *     2. Altered source versions must be plainly marked as such, and must not be misrepresented
 *     as being the original software.
 *
 *     3. This notice may not be removed or altered from any source distribution.
 */

package;

#if !cpp
#error 'Raylib supports only C++ target platforms.'
#end
import Raylib;

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('impl/rlights-impl.h')
@:unreflective
@:structAccess
@:native('Light')
extern class RayLight
{
    @:native('Light')
    static function alloc():RayLight;

    var type:Int;
    var enabled:Bool;
    var position:RayVector3;
    var target:RayVector3;
    var color:RayColor;
    var attenuation:Single;
    var enabledLoc:Int;
    var typeLoc:Int;
    var positionLoc:Int;
    var targetLoc:Int;
    var colorLoc:Int;
    var attenuationLoc:Int;
}

/*@:build(macros.ForwardPlus.forward(value, [
    (type:Int),
    (enabled:Bool),
    (position:RayVector3),
    (target:RayVector3),
    (color:RayColor),
    (attenuation:Single),
    (enabledLoc:Int),
    (typeLoc:Int),
    (positionLoc:Int),
    (targetLoc:Int),
    (colorLoc:Int),
    (attenuationLoc:Int)
]))
class Light {
    public var value:cpp.Struct<RayLight>;

    public function new(value:cpp.Struct<RayLight>) {
        if(value == null) value = RayLight.alloc();
        this.value = value;
    }

    public static function create(type:LightType, position:RayVector3, target:RayVector3, color:RayColor, shader:RayShader):Light {
        var light = RLights.createLight(type, position, target, color, shader);
        return new Light(light);
    }
}*/

@:include('impl/rlights-impl.h')
@:native('cpp.Struct<Light>')
extern class RayLightStruct extends RayLight

@:forward
extern abstract Light(RayLightStruct) to RayLightStruct
{
    inline function new():Void
    {
        this = RayLight.alloc();
    }

    @:from
    static inline function fromNative(value:RayLight):Light
        return cast value;

    @:to
    inline function toPointer():cpp.RawPointer<RayLight>
        return cast cpp.RawPointer.addressOf(this);
}

extern enum abstract LightType(LightTypeImpl)
{
    @:native('LIGHT_DIRECTIONAL') var LIGHT_DIRECTIONAL;
    @:native('LIGHT_POINT') var LIGHT_POINT;

    @:from
    public static inline function fromInt(i:Int):LightType
        return cast i;

    @:to
    public inline function toInt():Int
        return untyped this;
}

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('impl/rlights-impl.h')
@:native('LightType')
private extern class LightTypeImpl {}

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('impl/rlights-impl.h')
@:unreflective
extern class RLights
{
    @:native('CreateLight')
    static function createLight(type:Int, position:RayVector3, target:RayVector3, color:RayColor, shader:RayShader):RayLight;

    @:native('UpdateLightValues')
    static function updateLightValues(shader:RayShader, light:RayLight):Void;
}
