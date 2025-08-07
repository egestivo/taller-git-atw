const createBooksPanel = () => {

    const authorStore = Ext.getStore('authorStore');
    if (!authorStore) {
        throw new Error('authorStore not found, baboso Bv, load the author.js');
    }

    Ext.define('App.model.Book', {
        extend: 'Ext.data.Model',
        fields: [
            {name: 'id', type: 'int'},
            {name: 'title', type: 'string'},
            {name: 'description', type: 'string'},
            {name: 'publicationDate', type: 'date', dateFormat: 'Y-m-d'},
            {name: 'authorId', mapping: 'author.id', type: 'int' },
            {name: 'authorName', convert:(v,rec)=>{
                const a = rec.get('author');
                return a ? `${a.firstName} ${a.lastName}` : '';
            }},
            {name: 'isbn', type: 'string'},
            {name: 'genre', type: 'string'},
            {name: 'edition', type: 'int'}
        ]
    });

    const bookStore = Ext.create('Ext.data.Store', {
        storeId: 'bookStore',
        model: 'App.model.Book',
        proxy: {
            type: 'rest',
            url: 'api/book.php',
            reader: {
                type: 'json',
                rootProperty: 'data'
            }
        },
        autoLoad: true,
        autoSync: false
    });

    return Ext.create('Ext.grid.Panel', {
        id: 'booksPanel',
        title: 'Books',
        store: bookStore,
        columns: [
            {
                text: 'ID',
                sortable: false,
                hideable: false,
                dataIndex: 'id',
                width:40
            },
            {
                text: 'Title',
                sortable: false,
                hideable: false,
                dataIndex: 'title',
                flex: 1
            },
            {
                text: 'Description',
                sortable: false,
                hideable: false,
                dataIndex: 'description',
                flex: 1
            },
            {
                text: 'Publication Date',
                sortable: false,
                hideable: false,
                dataIndex: 'publicationDate',
                width: 100,
                xtype: 'datecolumn',
                format: 'Y-m-d'
            },
            {
                text: 'Author',
                sortable: false,
                hideable: false,
                dataIndex: 'authorName',
                width: 150
            },
            {
                text: 'ISBN',
                sortable: false,
                hideable: false,
                dataIndex: 'isbn',
                width: 150
            },
            {
                text: 'Genre',
                sortable: false,
                hideable: false,
                dataIndex: 'genre',
                width: 100
            },
            {
                text: 'Edition',
                sortable: false,
                hideable: false,
                dataIndex: 'edition',
                width: 50
            }
        ],
        tbar: [
            {
                text: 'Add Book',
            },
            {
                text: 'Edit Book',
            },
            {
                text: 'Delete Book',
            }
        ]
    });
};

window.createBooksPanel = createBooksPanel;
