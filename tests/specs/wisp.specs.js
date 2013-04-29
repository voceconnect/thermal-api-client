describe('WisP', function () {

    WisP.config.baseUrl = "stubs";

    describe('Post Model', function () {
        beforeEach(function () {
            this.post = new WisP.Post();
        });
        it('Post default should be set', function () {
            expect(this.post.get("id")).toBe(0);
        });
        it('Post should set given id', function () {
            post = new WisP.Post({id:1});
            expect(post.get("id")).toBe(1);
        });
        it('Url method should use baseUrl', function () {
            expect(this.post.url()).toBe('stubs/posts/0');
        });
        it('Fetch should set remote data', function () {
            post = new WisP.Post({id:100});
            post.listenTo(post, 'change', function(){
                expect(post.get('title')).toBe('Lorem Ipsum Dolor!');
            });
            post.fetch();
        });                
    });

    describe('Post View', function () {
        beforeEach(function () {
            this.postView = new WisP.PostView();
        });
        it('This template should be a function', function () {
            expect(typeof(this.postView.template)).toBe('function');
        });
        it('Render should create html with model data', function () {
            postView = new WisP.PostView({model: new WisP.Post});
            html = postView.render();
            expect($(html).find('h3').text()).toBe('Default Post Title');
        });
    });

    describe('Posts Collection', function () {
        beforeEach(function () {
            this.posts = new WisP.Posts([], {paged: 4});
        });

        it('The posts collection should set the page attribute', function () {
            expect(this.posts.paged).toBe(4);
        });
        it('The collection per page should match config', function () {
            expect(this.posts.per_page).toBe(WisP.config.per_page);
        });
        it('Adding model should add to collection', function () {
            this.posts.add([new WisP.Post]);
            expect(this.posts.models.length).toBe(1);
        });
        it('The url should use variables', function () {
            posts = new WisP.Posts([], {paged: 100});
            expect(posts.url).toBe('stubs/posts/?per_page=3&paged=100');
        });
        it('Should add option category', function () {
            posts = new WisP.Posts([], {category: 5});
            expect(posts.url).toBe('stubs/posts/?per_page=3&paged=1&cat=5');
        });        
        it('Should add models from remote', function () {
            posts = new WisP.Posts();
            length = posts.models.length;
            posts.fetch();
            posts.listenTo(posts, 'add', function(){
                expect(posts.models.length).toBe( length + 1  );
                length = length + 1;
            });
        });
    });

    describe('Post Archive View', function () {
        beforeEach(function () {
            this.posts = new WisP.Posts();
            this.postsView = new WisP.PostArchiveView({collection: this.posts});
        });
        it('Adding a model should render html', function () {
            html = this.postsView.renderOne(new WisP.Post());
            expect($(html).find('h3').text()).toBe('Default Post Title');
        });
        // it('Should render from remote', function () {
        //     posts = new WisP.Posts({paged: 2});
        //     postsView = new WisP.PostArchiveView({collection: posts});
        //     length = $(postsView.el).find('h3').length;
        //     posts.listenTo('add', function(){
        //         expect($(postsView.el).find('h3').length).toBe(3);
        //     });
        //     posts.fetch();
        // });        
    });

    describe('Router', function(){
        beforeEach(function(){
            this.router = new WisP.Router();
        });
        it('Show posts should create collection', function(){
            this.router.showPosts();
            expect(typeof this.router.posts).toBe('object');
        });
    });

});