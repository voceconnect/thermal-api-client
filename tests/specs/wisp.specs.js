var postJsonData = {};
$.ajax({
    dataType: 'json',
    url: 'stubs/posts/100/index.php',
    async: false,
    success: function (r) {
        postJsonData = r;
    }
});

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
            post = new WisP.Post({id: 1});
            expect(post.get("id")).toBe(1);
        });
        it('Url method should use baseUrl', function () {
            expect(this.post.url()).toBe('stubs/posts/0');
        });
        it('Fetch should set remote data', function () {
            var result;
            post = new WisP.Post({id: 100});
            getPost();

            waitsFor(function () {
                return result === true;
            }, "get remote model data", 3000);

            runs(function () {
                expect(post.get('title')).toBe('Lorem Ipsum Dolor!');
            });

            function getPost() {
                post.fetch({
                    success: function () {
                        result = true;
                    },
                    error: function () {
                        result = false;
                    }
                });
            }

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
            var result;
            posts = new WisP.Posts();
            getPosts();

            waitsFor(function () {
                return result === true;
            }, 'gets posts', 3000);

            runs(function () {
                expect(posts.models.length).toBe(3);
            });

            function getPosts() {
                posts.fetch({
                    success: function () {
                        result = true;
                    },
                    error: function () {
                        result = false;
                    }
                });

            }

        });
    });

    describe('Post Archive View', function () {
        beforeEach(function () {
            this.posts = new WisP.Posts();
            this.postsView = new WisP.PostArchiveView({collection: this.posts});
        });
        it('Adding a model should render html', function () {
            html = this.postsView.renderOne(new WisP.Post());
            expect($(html).find('h4 a').text()).toBe('Default Post Title');
        });
        it('Should render from remote', function () {
            var result;
            posts = new WisP.Posts({paged: 2});
            postsView = new WisP.PostArchiveView({collection: posts});
            length = $(postsView.el).find('h3').length;
            getPosts();
            waitsFor(function () {
                return result === true;
            }, "get posts", 3000);

            runs(function () {
                //expect($(postsView.el).find('h3').length).toBe(3);
            });

            function getPosts() {
                posts.fetch({
                    success: function () {
                        result = true;
                    },
                    error: function () {
                        result = false;
                    }
                })
            }

        });
    });

    describe('Controller', function () {
        beforeEach(function () {

        });
        it('showPosts should create collection', function () {
            WisP.Controller.showPosts();
            expect(typeof WisP.currentCollection).toBe('object');
        });

        it('showPosts should create collection with category', function () {
            WisP.Controller.showPosts('100');
            url = WisP.currentCollection.url;
            expect(url.substr(url.indexOf('cat'), 7)).toBe('cat=100');
        });

        it('morePosts should add posts to WisP.currentPosts', function () {
            WisP.Controller.morePosts();
            setTimeout(function(){
                expect(WisP.currentPosts.length).toBe(3);
            }, 300);
        });

        it('showPost should get post from ID', function () {
            WisP.Controller.showPost(100);
            expect(WisP.currentPost.get('id')).toBe(100);
        });

        it('showPost should set empty if ID not set', function () {
            WisP.Controller.showPost();
            expect(WisP.currentPost.get('id')).toBe(0);
        });

        it('showPost should get from memory if ID exists', function () {
            WisP.currentPosts = [
                new WisP.Post({id:100}),
                new WisP.Post({id:101, title:'foo'})
            ];
            WisP.Controller.showPost(101);
            expect(WisP.currentPost.get('title')).toBe('foo');
        });

        it('stepPost should get the next Post', function () {
            WisP.currentPosts = [
                new WisP.Post({id:100}),
                new WisP.Post({id:101, title:'foo'})
            ];
            expect(WisP.stepPost(100).get('id')).toBe(101);
        });

        it('stepPost should get the previous Post', function () {
            WisP.currentPosts = [
                new WisP.Post({id:100}),
                new WisP.Post({id:101, title:'foo'})
            ];
            expect(WisP.stepPost(101, true).get('id')).toBe(100);
        });

        it('stepPost should return same post if last', function () {
            WisP.currentPost = new WisP.Post({id:100});
            WisP.currentPosts = [
                new WisP.Post({id:100}),
                new WisP.Post({id:101, title:'foo'})
            ];
            expect(WisP.stepPost(100, true).get('id')).toBe(100);
        });
    });

    describe('Date.prototype', function () {
        beforeEach(function () {
        });

        it('Date.timeAgo should format for hours', function(){
            oneHourAgo = new Date();
            oneHourAgo.setHours(oneHourAgo.getHours() - 1);
            expect(oneHourAgo.timeAgo()).toBe('1 hour ago');
        });

        it('Date.timeAgo should format for just now', function(){
            justNow = new Date();
            expect(justNow.timeAgo()).toBe('just now');
        });
        it('Date.timeAgo should format for yesterday', function(){
            oneDayAgo = new Date();
            oneDayAgo.setDate(oneDayAgo.getDate() - 1);
            expect(oneDayAgo.timeAgo()).toBe('Yesterday');
        });

        it('Date.timeAgo should format for days', function(){
            twoDayAgo = new Date();
            twoDayAgo.setDate(twoDayAgo.getDate() - 2);
            expect(twoDayAgo.timeAgo()).toBe('2 days ago');
        });
    });

    describe('Get Featured Image', function () {
        beforeEach( function () {
        });

        it('Method should return image matching featured id', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByID(123456, media).id).toBe(123456);
        });
        it('Method should return false if id not found', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByID(123499, media)).toBe(false);
        });
        it('Method should return false if sizes is not set', function () {
            media = $.extend(true, {}, postJsonData.media);
            delete media[0].sizes;
            expect(WisP.getMediaByID(123456, media)).toBe(false);
        });
        it('Method should return false if sizes is empty', function () {
            media = $.extend(true, {}, postJsonData.media);
            media[0].sizes = [];
            expect(WisP.getMediaByID(123456, media)).toBe(false);
        });
        it('Method should return false if size url is not set', function () {
            media = $.extend(true, {}, postJsonData.media);
            delete media[0].sizes[0].url;
            expect(WisP.getMediaByID(123456, media)).toBe(false);
        });
        it('Method should return false if size url is empty', function () {
            media = $.extend(true, {}, postJsonData.media);
            media[0].sizes[0].url = "";
            expect(WisP.getMediaByID(123456, media)).toBe(false);
        });
        it('Alt text should return empty string if undefined', function () {
            media = $.extend(true, {}, postJsonData.media);
            delete media[0].altText;
            expect(WisP.getMediaByID(123456, media).altText).toBe("");
        });
    });
});