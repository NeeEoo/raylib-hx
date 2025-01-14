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

package hxraylib;

#if !cpp
#error 'Raylib supports only C++ target platforms.'
#end
import Raylib;

extern enum abstract TouchAction(TouchActionImpl)
{
    @:native('TOUCH_ACTION_UP') var TOUCH_ACTION_UP;
    @:native('TOUCH_ACTION_DOWN') var TOUCH_ACTION_DOWN;
    @:native('TOUCH_ACTION_MOVE') var TOUCH_ACTION_MOVE;
    @:native('TOUCH_ACTION_CANCEL') var TOUCH_ACTION_CANCEL;

    @:from
    public static inline function fromInt(i:Int):TouchAction
        return cast i;

    @:to
    public inline function toInt():Int
        return untyped this;
}

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('rgestures-impl.h')
@:native('TouchAction')
private extern class TouchActionImpl {}

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('rgestures-impl.h')
@:unreflective
@:structAccess
@:native('GestureEvent')
extern class RayGestureEvent
{
    @:native('GestureEvent')
    static function alloc():RayGestureEvent;

    var touchAction:Int;
    var pointCount:Int;
    var pointId:utils.IntPointer;
    var position:cpp.RawPointer<RayVector2>;
}

extern abstract GestureEvent(cpp.Struct<RayGestureEvent>) to cpp.Struct<RayGestureEvent>
{
    var touchAction(get, set):Int;

    inline function get_touchAction():Int
    {
        return this.touchAction;
    }

    inline function set_touchAction(value:Int):Int
    {
        return this.touchAction = value;
    }

    var pointCount(get, set):Int;

    inline function get_pointCount():Int
    {
        return this.pointCount;
    }

    inline function set_pointCount(value:Int):Int
    {
        return this.pointCount = value;
    }

    var pointId(get, set):utils.IntPointer;

    inline function get_pointId():utils.IntPointer
    {
        return this.pointId;
    }

    inline function set_pointId(value:utils.IntPointer):utils.IntPointer
    {
        return this.pointId = value;
    }

    var position(get, set):cpp.RawPointer<RayVector2>;

    inline function get_position():cpp.RawPointer<RayVector2>
    {
        return this.position;
    }

    inline function set_position(value:cpp.RawPointer<RayVector2>):cpp.RawPointer<RayVector2>
    {
        return this.position = value;
    }

    inline function new():Void
    {
        this = RayGestureEvent.alloc();
    }

    @:from
    public static inline function fromNative(value:RayGestureEvent):GestureEvent
        return cast value;

    @:to
    public inline function toPointer():cpp.RawPointer<RayGestureEvent>
        return cast cpp.RawPointer.addressOf(this);
}

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('rgestures-impl.h')
@:unreflective
extern class RGestures
{
    @:native('ProcessGestureEvent')
    static function ProcessGestureEvent(event:RayGestureEvent):Void;

    @:native('UpdateGestures')
    static function UpdateGestures():Void;
}
