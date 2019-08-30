import React, { Component } from 'react';
import { StyleSheet, Text, View, Image, Button } from 'react-native';

const styles = StyleSheet.create({
  bigBlue: {
    color: "blue",
    fontWeight: "bold",
    fontSize: 30,
  },
  red: {
    color: "red",
  },
  buttonContainer: {
    margin: 20
  },
});

class Greeting extends Component {
  render() {
    return (
      <View style={{alignItems: "center"}}>
        <Text>Hello {this.props.name}!</Text>
      </View>
    )
  }
}

class HelloWorld extends Component {
  render() {
    let pic = {
      uri: "https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg"
    };
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <Text>Hello</Text>
        <Image source={pic} style={{width: 110, height: 50}} />
      </View>
    )
  }
}

class Greetings extends Component {
  render() {
    return (
      <View style={{alignItems: "center", top: 50}}>
        <Greeting name="JarJar"/>
        <Greeting name="Bla"/>
      </View>
    )
  }
}

class Colors extends Component {
  render() {
    return (
      <View style={{alignItems: "center", top: 50}}>
        <Text style={styles.bigBlue}>MastocBlue</Text>
        <Text style={styles.bigBlue, styles.red}>redthenblue</Text>
      </View>
    )
  }
}

class FlexIt extends Component {
  render() {
    return (
      <View style={{flex:1}}>
        <View style={{flex:1, backgroundColor: "powderblue"}}/>
        <View style={{flex:2, backgroundColor: "skyblue"}}/>
        <View style={{flex:3, backgroundColor: "steelblue"}}/>
      </View>
    )
  }
}

class Menu extends Component {
  _addTodo() {
    alert("not implemeted yet");
  }

  render() {
    return (
      <View style={{flex:1, height: 60, flexDirection: "row"}}>
        <View style={{flex: 1, width: 60, backgroundColor: "red", alignItems: "center", justifyContent: "center"}}>
          <Button onPress={this._addTodo} title="Add"/>
        </View>
        <View style={{flex: 5, backgroundColor: "orange", alignSelf: "stretch"}}/>
      </View>
    )
  }
}

class Todo extends Component {
  _delTodo() {
    alert("not implemeted yet");
  }
  render() {
    return (
      <View style={{flex:1, maxHeight: 60, minHeight: 60, flexDirection: "row"}}>
        <View style={{flex:1, minWidth: 30, maxWidth: 100, justifyContent: "center", backgroundColor: "red"}}>
          <Button onPress={this._delTodo} title="Del"/>
        </View>
        <View style={{flex:10, backgroundColor: "white", justifyContent: "center"}}>
          <Text style={{margin: 5}}>{this.props.description}</Text>
        </View>
      </View>
    )
  }
}

export default class Main extends Component {
  render() {
    return (
      <View style={{flex:1}}>
        <Menu/>
        <View style={{flex:10, backgroundColor: "gray", alignItems: "center"}}>
          <Text>Todos:</Text>
          <Todo description="first job"/>
          <Todo description="second job"/>
        </View>
      </View>
    )
  }
}
