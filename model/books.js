const mongoose = require("mongoose");

const bookSchema = new mongoose.Schema({
    bookId: {
        type: String,
    },
    title: {
        type:String,
    },
    imagUrl: {
        type:String,
    },
    author: {
        authId: {
            type:String,
        },
        authName: {
            type:String,
        }
    },
    category: {
        catId: {
            type:String,
        },
        catName: {
            type:String,
        }
    }
});

module.exports = mongoose.model("Books", bookSchema);