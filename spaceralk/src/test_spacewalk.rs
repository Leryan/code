extern crate serde_json;
extern crate xmlrpc;

use spacewalk::*;

#[test]
fn json_decode_empty_array() {
    let jdoc = serde_json::from_str("[]").unwrap();
    let xmldoc = decode_json_value(jdoc);

    match xmldoc {
        xmlrpc::Value::Array(xarr) => assert_eq!(0, xarr.len()),
        _ => assert!(false, "another type was returned {:?}", xmldoc),
    };
}

#[test]
fn json_decode_sub_array() {
    let jdoc = serde_json::from_str("[[], [null]]").unwrap();
    let xmldoc = decode_json_value(jdoc);

    match xmldoc {
        xmlrpc::Value::Array(xarr) => {
            match xarr[0] {
                xmlrpc::Value::Array(ref xxarr) => assert_eq!(0, xxarr.len()),
                _ => assert!(false, "wrong decoding #1"),
            };
            match xarr[1] {
                xmlrpc::Value::Array(ref xxarr) => assert_eq!(1, xxarr.len()),
                _ => assert!(false, "wrong decoding #2"),
            }
        }
        _ => assert!(false, "another type was returned {:?}", xmldoc),
    };
}

#[test]
fn json_decode_number() {
    let jdoc: serde_json::Value = serde_json::from_str("[1]").unwrap();
    let xmldoc = decode_json_value(jdoc[0].clone());

    match xmldoc {
        xmlrpc::Value::Double(xmlint) => assert_eq!(1.0, xmlint),
        _ => assert!(false, "another type was returned {:?}", xmldoc),
    };
}

#[test]
fn json_decode_string() {
    let jdoc: serde_json::Value = serde_json::from_str("[\"string\"]").unwrap();
    let xmldoc = decode_json_value(jdoc[0].clone());

    match xmldoc {
        xmlrpc::Value::String(xmlstr) => assert_eq!("string", xmlstr),
        _ => assert!(false, "another type was returned {:?}", xmldoc),
    };
}

#[test]
fn json_decode_bool() {
    let jdoc: serde_json::Value = serde_json::from_str("[true, false]").unwrap();
    let xbt = decode_json_value(jdoc[0].clone());
    let xbf = decode_json_value(jdoc[1].clone());

    match xbt {
        xmlrpc::Value::Bool(bt) => assert_eq!(true, bt),
        _ => assert!(false, "another type was returned {:?}", xbt),
    };

    match xbf {
        xmlrpc::Value::Bool(bf) => assert_eq!(false, bf),
        _ => assert!(false, "another type was returned {:?}", xbf),
    };
}

#[test]
fn json_decode_nil() {
    let jdoc: serde_json::Value = serde_json::from_str("[null]").unwrap();
    let xnil = decode_json_value(jdoc[0].clone());

    assert_eq!(xnil, xmlrpc::Value::Nil);
}
