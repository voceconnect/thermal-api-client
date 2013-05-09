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


    describe('Media Model', function () {
        beforeEach(function () {
            this.media = new WisP.Media();
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
            expect($(postView.el).find('h3').text()).toBe('Default Post Title');
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
            expect(posts.url).toBe('stubs/posts/?per_page=3&paged=100&include_found=1');
        });
        it('Should add option category', function () {
            posts = new WisP.Posts([], {category: 5});
            expect(posts.url).toBe('stubs/posts/?per_page=3&paged=1&include_found=1&cat=5');
        });
        it('Should add models from remote', function () {
            var result;
            posts = new WisP.Posts();
            getPosts();

            waitsFor(function () {
                return result === true;
            }, 'gets posts', 3000);

            runs(function () {
                expect(posts.models.length).toBeGreaterThan(0);
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
                expect(WisP.currentPosts.length).toBeGreaterThan(0);
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
            delete media[0].alt_text;
            expect(WisP.getMediaByID(123456, media).alt_text).toBe("");
        });
        it('Method should return false if no args are passed', function () {
            expect(WisP.getMediaByID()).toBe(false);
        });
        it('Method should return false if invalid data types are passed', function () {
            expect(WisP.getMediaByID('asdf', 1234)).toBe(false);
        });
    });

    describe('Term Model', function () {
        beforeEach(function () {
            this.term = new WisP.Term();
        });
        it('Term default should be set', function () {
            expect(this.term.get('id')).toBe(0);
        });
        it('Term should set given id', function () {
            term = new WisP.Term({id: 1});
            expect(term.get('id')).toBe(1);
        });
    });

    describe('Terms Collection', function () {
        beforeEach(function () {
            this.terms = new WisP.Terms([], {taxonomy: 'category'});
        });

        it('Adding model should add to collection', function () {
            this.terms.add([new WisP.Term]);
            expect(this.terms.models.length).toBe(1);
        });
        it('The url should use variables', function () {
            terms = new WisP.Terms([], {taxonomy: 'category'});
            expect(terms.url).toBe('stubs/taxonomies/category/terms/');
        });
        it('Should add models from remote', function () {
            var result;
            terms = new WisP.Terms();
            getTerms();

            waitsFor(function () {
                return result === true;
            }, 'gets terms', 3000);

            runs(function () {
                expect(terms.models.length).toBeGreaterThan(0);
            });

            function getTerms() {
                terms.fetch({
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

    describe('Category Menu View', function () {
        beforeEach(function () {
            this.terms = new WisP.Terms({taxonomy: 'category'});
            this.$el = $('<div><div class="dropdown-toggle"></div><div class="dropdown-menu"></div></div>');
            this.categoryMenuView = new WisP.CategoryMenuView({collection: this.terms, el: this.$el});
        });
        it('Adding a model should render html', function () {
            html = this.categoryMenuView.renderOne(new WisP.Term({id: 1, name:'Test Taxonomy Name'}));
            expect($(html).find('li a').text()).toBe('Test Taxonomy Name');
        });
        it('Should render from remote', function () {
            var result,
            _this = this;
            getCats();
            waitsFor(function () {
                return result === true;
            }, "get cats", 3000);

            runs(function () {
                expect($(_this.categoryMenuView.el).find('li').length).toBe(3);
            });

            function getCats() {
                _this.terms.fetch({
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

    describe('Get Pretty URL', function () {
        beforeEach( function () {
        });

        it('Method should return root domain for fully qualified url', function () {
            url = 'http://www.example.com/post/something';
            expect(WisP.getPrettyURL(url)).toBe('example.com');
        });
        it('Method should return false if empty string', function () {
            url = '';
            expect(WisP.getPrettyURL(url)).toBe(false);
        });
        it('Method should return false if no argument is passed', function () {
            expect(WisP.getPrettyURL()).toBe(false);
        });
    });

    describe('Get Media By Width', function () {
        beforeEach( function () {
        });

        it('Method should return smallest size greater than requested value', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByWidth(media[0].sizes, 150).width).toBe(300);
        });
        it('Method should return false when passed empty array', function () {
            expect(WisP.getMediaByWidth([], 150)).toBe(false);
        });
        it('Method should return false when passed invalid types', function () {
            expect(WisP.getMediaByWidth(150, '')).toBe(false);
        });
        it('Method should return false when not passed any args', function () {
            expect(WisP.getMediaByWidth(150, '')).toBe(false);
        });
        it('Method should return false if no size is passed', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByWidth(media[0].sizes.reverse())).toBe(false);
        });
        it('Method should return largest image if all sizes are less than requested', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByWidth(media[0].sizes, 9999).width).toBe(600);
        });
        it('Method should return exact size if found', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByWidth(media[0].sizes, 100).width).toBe(100);
        });
        it('Method should return closest image if sizes are reversed and closest is not the first found', function () {
            media = $.extend(true, {}, postJsonData.media);
            expect(WisP.getMediaByWidth(media[0].sizes.reverse(), 150).width).toBe(300);
        });
    });
});