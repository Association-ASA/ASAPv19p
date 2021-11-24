// CodeMirror, copyright (c)
// Distributed under an MIT license: https://codemirror.net/LICENSE

(function(mod) {
  if (typeof exports == "object" && typeof module == "object") // CommonJS
    mod(require("../../lib/codemirror"));
  else if (typeof define == "function" && define.amd) // AMD
    define(["../../lib/codemirror"], mod);
  else // Plain browser env
    mod(CodeMirror);
})(function(CodeMirror) {
"use strict";

CodeMirror.defineMode("4d", function(conf, parserConf) {
    function wordRegexp(words) {
        return new RegExp("^((" + words.join(")|(") + "))\\b", "i");
    }

    var singleOperators = new RegExp("^[\\+\\-\\*\\/&|\\\\\\^<>=#%\\:]");
    var doubleOperators = new RegExp("^((<=)|(>=)|(\\:=)|(\\^\\|)|(<<)|(>>)|(\\?\\+)|(\\?\\-)|(\\?\\?)|(\\*\\+)|(\\*\\/))");
    var wordOperators = wordRegexp(['xor', 'eqv', 'imp']);
    var singleDelimiters = new RegExp('^[\\.,;]');
    var brakets = new RegExp('^[\\(\\)\\{\\}\\[\\]]');

    var identifiers = new RegExp("^[A-Za-z][_A-Za-z0-9]*");

    var openingKeywords = ['if','case of','for each','for','while','repeat','use','begin sql','si','au cas où','pour chaque','boucle','tant que','répéter','début SQL'];
    var middleKeywords = ['else','sinon'];
    var endKeywords = ['end if','end case','end for each','end for','end while','until','end use','end sql','fin de si','fin de cas','fin de chaque','fin tant que','fin de boucle','jusque','fin SQL'];

    var commonkeywords = ['xxxxzzzz'];

    var atomWords = ['xxxxzzzz'];

    var builtinFuncsWords = <!--#4DHTML $1-->;

    var builtinConsts = <!--#4DHTML $2-->;

    var builtinObjsWords = <!--#4DHTML $4-->;

    var knownProperties = [];
    
    var knownMethods = <!--#4DHTML $3-->;

    var knownWords = knownMethods.concat(knownProperties);

    builtinObjsWords = builtinObjsWords.concat(builtinConsts);

    var keywords = wordRegexp(commonkeywords);
    var atoms = wordRegexp(atomWords);
    var builtinFuncs = wordRegexp(builtinFuncsWords);
    var builtinObjsVars = wordRegexp(builtinObjsWords);
    var builtinObjsConst = wordRegexp(builtinConsts);
    var known = wordRegexp(knownWords);
    var stringPrefixes = '"';
    var datePrefixes = '!';

    var opening = wordRegexp(openingKeywords);
    var middle = wordRegexp(middleKeywords);
    var closing = wordRegexp(endKeywords);
    var doubleClosing = wordRegexp(['xxxxzzzz']);
    var doOpening = wordRegexp(['xxxxzzzz']);
    var noIndentWords = wordRegexp(['xxxxzzzz']);
    var locVar = wordRegexp(['\\$\\w{1,31}']);
    var ipVar = wordRegexp(['<>\\w{1,31}']);
    var comment = new RegExp("^(\\/\\/)");

    function indent(_stream, state) {
      state.currentIndent++;
    }

    function dedent(_stream, state) {
      state.currentIndent--;
    }
    // tokenizers
    var type, content;
    function ret(tp, style, cont) {
      type = tp; content = cont;
      return style;
    }
    function tokenBase(stream, state) {
        if (stream.eatSpace()) {
            return 'space';
            //return null;
        }

        // Handle Comments
        if (stream.match(comment)){
            stream.skipToEnd();
            return 'comment';
        }
        if (stream.match('/')) {
          if (stream.eat("*")) {
            state.tokenize = tokenComment;
            return tokenComment(stream, state);
          }
        }

        // Handle Number Literals
        if (stream.match(/^((&H)|(&O))?[0-9\.]/i, false) && !stream.match(/^((&H)|(&O))?[0-9\.]+[a-z_]/i, false)) {
            var floatLiteral = false;
            // Floats
            if (stream.match(/^\d*\.\d+/i)) { floatLiteral = true; }
            else if (stream.match(/^\d+\.\d*/)) { floatLiteral = true; }
            else if (stream.match(/^\.\d+/)) { floatLiteral = true; }

            if (floatLiteral) {
                // Float literals may be "imaginary"
                stream.eat(/J/i);
                return 'number';
            }
            // Integers
            var intLiteral = false;
            // Hex
            if (stream.match(/^&H[0-9a-f]+/i)) { intLiteral = true; }
            // Octal
            else if (stream.match(/^&O[0-7]+/i)) { intLiteral = true; }
            // Decimal
            else if (stream.match(/^[1-9]\d*F?/)) {
                // Decimal literals may be "imaginary"
                stream.eat(/J/i);
                // TODO - Can you have imaginary longs?
                intLiteral = true;
            }
            // Zero by itself with no other piece of number.
            else if (stream.match(/^0(?![\dx])/i)) { intLiteral = true; }
            if (intLiteral) {
                // Integer literals may be "long"
                stream.eat(/L/i);
                return 'number';
            }
        }

        // Handle Strings
        if (stream.match(stringPrefixes)) {
            state.tokenize = tokenStringFactory(stream.current());
            return state.tokenize(stream, state);
        }
        if (stream.match(datePrefixes)) {
            state.tokenize = tokenDateFactory(stream.current());
            return state.tokenize(stream, state);
        }

        if (stream.match(ipVar)) {
            return 'variable-2';
        }

        // Handle operators and Delimiters
        if (stream.match(doubleOperators) || stream.match(singleOperators) || stream.match(wordOperators)) {
            return 'operator';
        }
        if (stream.match(singleDelimiters)) {
            return null;
        }

        if (stream.match(brakets)) {
            return "bracket";
        }

        if (stream.match(noIndentWords)) {
            state.doInCurrentLine = true;
            return 'keyword';
        }

        if (stream.match(doOpening)) {
            indent(stream,state);
            state.doInCurrentLine = true;
            return 'keyword';
        }
        if (stream.match(opening)) {
            if (! state.doInCurrentLine)
              indent(stream,state);
            else
              state.doInCurrentLine = false;
            return 'keyword blockBegin';
        }
        if (stream.match(middle)) {
            return 'keyword blockMiddle';
        }

        if (stream.match(doubleClosing)) {
            dedent(stream,state);
            dedent(stream,state);
            return 'keyword';
        }
        if (stream.match(closing)) {
            if (! state.doInCurrentLine)
              dedent(stream,state);
            else
              state.doInCurrentLine = false;
            return 'keyword blockEnd';
        }

        if (stream.match(locVar)) {
            return 'variable-3';
        }

        if (stream.match(keywords)) {
            return 'keyword';
        }

        if (stream.match(atoms)) {
            return 'atom';
        }

        if (stream.match(known)) {
            return 'tag';
        }

        if (stream.match(builtinFuncs)) {
            return 'builtin';
        }

        if (stream.match(builtinObjsConst)){
            return 'attribute';
        }

        if (stream.match(identifiers)) {
            return 'variable';
        }

        if (stream.match(/0x[0-9a-fA-F]{1,8}/)) {
            return 'variable';
        }

        // Handle non-detected items
        stream.next();
        return 'error';
    }

    function tokenStringFactory(delimiter) {
        var singleline = delimiter.length == 1;
        var OUTCLASS = 'string';

        return function(stream, state) {
            while (!stream.eol()) {
                stream.eatWhile(/[^'"]/);
                if (stream.match(delimiter)) {
                    state.tokenize = tokenBase;
                    return OUTCLASS;
                } else {
                    stream.eat(/['"]/);
                }
            }
            if (singleline) {
                if (parserConf.singleLineStringErrors) {
                    return 'error';
                } else {
                    state.tokenize = tokenBase;
                }
            }
            return OUTCLASS;
        };
    }

    function tokenDateFactory(delimiter) {
        var singleline = delimiter.length == 1;
        var OUTCLASS = 'string';

        return function(stream, state) {
            while (!stream.eol()) {
                stream.eatWhile(/[^!]/);
                if (stream.match(delimiter)) {
                    state.tokenize = tokenBase;
                    return OUTCLASS;
                } else {
                    stream.eat(/[!]/);
                }
            }
            if (singleline) {
                if (parserConf.singleLineStringErrors) {
                    return 'error';
                } else {
                    state.tokenize = tokenBase;
                }
            }
            return OUTCLASS;
        };
    }

  function tokenComment(stream, state) {
    var maybeEnd = false, ch;
    while (ch = stream.next()) {
      if (ch == "/" && maybeEnd) {
        state.tokenize = tokenBase;
        break;
      }
      maybeEnd = (ch == "*");
    }
    return ret("comment", "comment");
  }

    function tokenLexer(stream, state) {
        var style = state.tokenize(stream, state);
        var current = stream.current();

        // Handle '.' connected identifiers
        if (current === '.') {
            style = state.tokenize(stream, state);

            current = stream.current();
            if (style && (style.substr(0, 8) === 'variable' || style==='builtin' || style==='keyword')){//|| knownWords.indexOf(current.substring(1)) > -1) {
                if (style === 'builtin' || style === 'keyword') style='variable';
                if (knownWords.indexOf(current.substr(1)) > -1) style='variable-2';

                return style;
            } else {
                return 'error';
            }
        }

        return style;
    }

    var external = {
        electricChars:"dDpPtTfFeE ",
        startState: function() {
            return {
              tokenize: tokenBase,
              lastToken: null,
              currentIndent: 0,
              nextLineIndent: 0,
              doInCurrentLine: false,
              ignoreKeyword: false


          };
        },

        token: function(stream, state) {
            if (stream.sol()) {
              state.currentIndent += state.nextLineIndent;
              state.nextLineIndent = 0;
              state.doInCurrentLine = 0;
            }

            if (state.tokenize != tokenComment && stream.eatSpace()) return null;

            var style = tokenLexer(stream, state);

            state.lastToken = {style:style, content: stream.current()};

            if (style==='space') style=null;

            return style;
        },

        indent: function(state, textAfter) {
            var trueText = textAfter.replace(/^\s+|\s+$/g, '') ;
            if (trueText.match(closing) || trueText.match(doubleClosing) || trueText.match(middle)) return conf.indentUnit*(state.currentIndent-1);
            if(state.currentIndent < 0) return 0;
            return state.currentIndent * conf.indentUnit;
        },

        blockCommentStart: '/*',
        blockCommentEnd: '*/'

    };
    return external;
});

CodeMirror.defineMIME("text/x-4d", "4d");

});