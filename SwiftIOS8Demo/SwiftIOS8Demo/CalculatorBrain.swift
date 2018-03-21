//
//  CalculatorBrain.swift
//  Calculator_Swift_Modi
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

class CalculatorBrain {
    //用枚举类型的数据结构来描述模型类
    enum Op:CustomStringConvertible {
        //Swift特性：将数据与case中的枚举关联起来:被关联的case分支枚举拥有对应关联类型的值
        case Operand(Double)    //操作数：当Op表示一个操作数(Operand)时
        case UnaryOperation(String,(Double) -> Double)      //一元运算
        case BinaryOperation(String,(Double,Double) -> Double)      //二元运算
        //重写类描述:计算型属性：间接设置或获取某个存储属性的值:重写该属性需要实现Printable协议Swift2.0后改为CustomStringConvertible
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let operation, _):
                    return operation
                case .BinaryOperation(let operation, _):
                    return operation
                }
            }
        }
    }
    //栈
    var opStack = [Op]()
    //已知运算
    var knownOps = [String:Op]()
    //初始化已知(基本)运算
    init() {
        //为了减少符号重复书写: 局部函数
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        learnOp(op: Op.BinaryOperation("*", *))
        learnOp(op: Op.BinaryOperation("/") {$1 / $0})
        learnOp(op: Op.BinaryOperation("+", +))
        learnOp(op: Op.BinaryOperation("-") {$1-$0})
        learnOp(op: Op.UnaryOperation("√", sqrt))
//        knownOps["/"] = Op.BinaryOperation("/") {$1 / $0}
//        knownOps["+"] = Op.BinaryOperation("+", +)
//        knownOps["-"] = Op.BinaryOperation("-") {$1-$0}
//        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            //参数ops是通过结构体值传递得到的不可变数组：此处转为可变数组
            var remainingOps = ops
            //获取到栈顶元素
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation): //不关心的变量可用_代替
                //递归
                let operandEvaluation = evaluate(ops: remainingOps)
                if let operand = operandEvaluation.result {
                   return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                //递归
                let op1Evaluation = evaluate(ops: remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(ops: op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
                //可能情况都已经处理故省略default
                //default break;
            }
        }
        return (nil, ops)
    }
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(ops: opStack)
        
        //打印栈里面内容变化情况:没有重写栈(opStack)的description时返回结果为Enum Value，故需要重写description
        print("opStack:\(opStack) = result:\(result) + remainder:\(remainder)")
        return result
    }
    
    //将操作数压栈
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        //如果已存在该算法则入栈
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
