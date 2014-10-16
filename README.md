Sudoku
=========

Sudoku (Digit-single), originally called Number Place, is a logic-based, combinatorial number-placement puzzle. [wiki]

Outline 
----
This is a backbone-like application but all are build from scratch.

Tools
----

 - Javascript: Coffeescript, JQuery, jade.js, require.js
 - CSS: Sass
 - HTML: jade
 - development tool: Grunt

Javascript Architecture
----
  - models: work on localStorage/db
    - baseModel
        - Game
  - views: alias controllers, with an optionl dom element and set event handlers to elements, optionally have some subViews
    - Event
        - baseView
            - gridView
            - lobbyView
            - popupView
            - boardView
                - sudokuBoard 
  
Tradeoff
----
 - I don't take backbone events instance object convention but use a setHandlers method to bind handlers. It makes more flexible but less consistent.
 - Use event delegate on view element to handle dynamically generated elements which don't have view bind on it, eg. list.

Optimize
----

 - popupView should be more general, could handle inputPopup and winPopup
 - should create a super sass file to contain all mixin and required modules and use another sub sass file to include it.
 
Version
----

1.0


Installation
--------------

 - have node & npm installed
 - have grunt-cli installed
 - run

```sh
npm install
grunt
```

[wiki]: http://en.wikipedia.org/wiki/Sudoku


