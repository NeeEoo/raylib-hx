package macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.Tools;

class ForwardPlus {
	// @:build(macros.ForwardPlus.forward(value, [ field:Type, field:Type ]))
	public static function forward(valueField:Expr, fields:Expr):Array<Field> {
		var extraFields:Array<Field> = [];
		var fields = switch (fields.expr) {
			case EArrayDecl(fields): fields;
			default: throw "Invalid fields: " + fields;
		}
		for (field in fields) {
			var fieldName:String = switch (field.expr) {
				case EParenthesis(_.expr => ECheckType(_.expr => EConst(CIdent(s)), t)): s;
				case ECheckType(_.expr => EConst(CIdent(s)), t): s;
				default: throw "Invalid field: " + field;
			}
			var fieldType = switch (field.expr) {
				case EParenthesis(_.expr => ECheckType(e, t)): t;
				case ECheckType(e, t): t;
				default: throw "Invalid field: " + field;
			}
			extraFields.push({
				name: fieldName,
				pos: Context.currentPos(),
				access: [APublic],
				kind: FProp("get", "set", fieldType, null)
			});

			extraFields.push({
				name: "get_" + fieldName,
				pos: Context.currentPos(),
				access: [APrivate, AInline],
				kind: FFun({
					args: [],
					ret: fieldType,
					expr: macro return $valueField.$fieldName
				})
			});

			extraFields.push({
				name: "set_" + fieldName,
				pos: Context.currentPos(),
				access: [APrivate, AInline],
				kind: FFun({
					args: [{
						name: "_",
						type: fieldType
					}],
					ret: fieldType,
					expr: macro return $valueField.$fieldName = _
				})
			});
		}

		var fields = Context.getBuildFields();

		fields = fields.concat(extraFields);

		//var printer = new haxe.macro.Printer();
		//for(field in fields) {
		//	Sys.println(printer.printField(field));
		//}

		return fields;
	}
}
#end